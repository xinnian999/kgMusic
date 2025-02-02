import { singerAudiosApi } from './api'
import type { AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'
import PlayBar from '../../components/PlayBar';
import AudioRow from '../../components/AudioRow';
import { SingerItem, SingerAudio } from '../../interface/singer';
import PlayList from '../../components/playList';
import { AudioRowItem } from '../../interface/components';


@Entry
@Component
struct Detail {
  routerParams: SingerItem = router.getParams() as SingerItem;
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

            PlayList({
              dataSource: this.singerAudios.map<AudioRowItem>(v => ({
                aid: v.audio_id,
                name: v.audio_name,
                author: v.author_name,
                hash: v.hash,
                albumId: v.album_id,
                avatar: ''
              }))
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