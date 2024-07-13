import { singerAudiosApi, singerAlbumsApi } from './api'
import type { AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'
import { Singer } from '.';
import { getMusicUrlApi } from '../../api/getUrl';
import { AVPlayerDemo } from '../audio';
import { media } from '@kit.MediaKit';


interface SingerAudio {
  audio_name: string,
  author_name: string,
  album_name: string,
  hash: string
}

interface SingerAlbum {
  album_name: string,
  sizable_cover: string
}

@Entry
@Component
struct Detail {
  routerParams: Singer = router.getParams() as Singer;
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @State singerAudios: SingerAudio[] = []
  @State singerAlbums: SingerAlbum[] = []
  private handlePlay = async (data: SingerAudio) => {
    //先取消上一个audio
    this.audio?.release()

    const res: AxiosResponse = await getMusicUrlApi(data.hash)
    const url: string = res.data.url[0]
    this.audio = await new AVPlayerDemo().avPlayerLiveDemo(url)
  }

  async onDidBuild() {
    const audiosRes: AxiosResponse = await singerAudiosApi(this.routerParams.singerid) as AxiosResponse
    const albumsRes: AxiosResponse = await singerAlbumsApi(this.routerParams.singerid) as AxiosResponse

    this.singerAudios = audiosRes.data.data
    this.singerAlbums = albumsRes.data.data
  }

  build() {
    Scroll() {
      Column() {
        Column() {
          Column({ space: 15 }) {
            Image(this.routerParams.imgurl.replace('\{size\}',
              '120')).width(50).height(50).borderRadius(50).border({ width: 1, color: '#fff' })
            Text(this.routerParams.singername).fontColor('#fff').fontWeight('700').fontSize(18).margin({})

            Text() {
              Span(`${(this.routerParams.fanscount / 10000).toFixed(1)}万 `).fontSize(16).fontColor('#fff')
              Span('粉丝').fontSize(13).fontColor('#ffe3e2e2')
            }
          }.position({ x: 0, y: '100%' }).markAnchor({ y: '100%' }).alignItems(HorizontalAlign.Start)

        }
        .height(300)
        .width('100%')
        .backgroundImage(this.routerParams.imgurl.replace('\{size\}', '850'))
        .backgroundImageSize(ImageSize.Cover)
        .padding(15)


        ForEach(this.singerAudios, (item: SingerAudio, index) => {
          GridItem() {
            Flex({ alignItems: ItemAlign.Center }) {
              Column() {
                Image(this.singerAlbums.find(v => v.album_name === item.album_name)?.sizable_cover.replace('\{size\}',
                  '120'))
              }.width(50).height(50)

              Column() {
                Text(item.audio_name).margin({ bottom: 10 })
                Text(item.author_name).fontSize(13).fontColor('#999')
              }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
            }.height(90).padding(20).onClick(() => this.handlePlay(item))
          }
        })

      }
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .scrollBarColor("#999")
    .scrollBarWidth(5)
    .edgeEffect(EdgeEffect.Fade)
    .height('100%')

  }
}