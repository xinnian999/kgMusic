import { singerListApi } from './api'
import type { AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'
import PlayBar from '../PlayBar'

export interface Singer {
  imgurl: string,
  singername: string,
  fanscount: number,
  singerid: number
}

@Entry
@Component
struct Index {
  @State singerList: Singer[] = []

  async onDidBuild() {
    const res: AxiosResponse = await singerListApi()
    // console.log(JSON.stringify(res.data.data.info))
    this.singerList = res.data.data.info[0].singer
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          ForEach(this.singerList, (item: Singer, index) => {
            GridItem() {
              Flex({ alignItems: ItemAlign.Center }) {
                Column() {
                  Image(item.imgurl.replace('\{size\}', '120')).borderRadius(50)
                }.width(50).height(50)

                Column() {
                  Text(item.singername).margin({ bottom: 10 })
                  Text(`粉丝数:${(item.fanscount / 10000).toFixed(1)}万`).fontSize(12).fontColor('#999')
                }.alignItems(HorizontalAlign.Start).margin({ left: 15 })

              }.height(100).padding(20).onClick(() => {
                router.pushUrl({
                  url: 'pages/Singer/Detail', params: item
                })
              })
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

      PlayBar()

    }

  }
}