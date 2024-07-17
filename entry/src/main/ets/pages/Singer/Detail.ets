import { singerAudiosApi } from './api'
import type { AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'
import { Singer } from '.';
import PlayBar from '../../components/PlayBar';
import AudioRow from '../../components/AudioRow';
import { JSON } from '@kit.ArkTS';


interface SingerAudio {
  audio_id: number,
  album_id: number,
  audio_name: string,
  author_name: string,
  album_name: string,
  hash: string
}

@Entry
@Component
struct Detail {
  routerParams: Singer = router.getParams() as Singer;
  @State singerAudios: SingerAudio[] = []

  async onDidBuild() {
    const audiosRes: AxiosResponse = await singerAudiosApi(this.routerParams.singerid) as AxiosResponse

    this.singerAudios = audiosRes.data.data
  }

  build() {
    Column() {
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

          Column() {
            ForEach(this.singerAudios, (item: SingerAudio, index) => {

              AudioRow({
                aid: item.audio_id,
                name: item.audio_name,
                author: item.author_name,
                hash: item.hash,
                albumId: item.album_id,
              })
            })
          }
          .padding({ left: 15, right: 15 })

        }
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .scrollBarColor("#999")
      .scrollBarWidth(5)
      .edgeEffect(EdgeEffect.Fade)
      .height('100%')

      PlayBar()
    }

  }
}