import Menus from './menus'
import type { Item } from './menus'
import router from '@ohos.router'

@Component
export default struct My {
  @Builder
  Item(data: Item) {
    Column() {
      Text(data.title).fontColor('#fff').fontSize(14)
      Text(data.desc).fontColor('#fff').fontSize(10).margin({ top: 10 })
    }
    .backgroundColor(data.bg)
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .borderRadius(10)
    .padding(10)
    .onClick(() => {
      if (data.to) {
        router.pushUrl({ url: data.to, params: null })
      }
    })
  }

  build() {
    Column() {
      TextInput({ placeholder: 'search...' }).height(40)

      Scroll() {
        Flex() {
          Column() {
            this.Item({
              title: '每日推荐', desc: '精选30首', bg: '#571fa0'
            })
          }.width(120).margin({ right: 10 })

          Grid() {

            ForEach(Menus, (item: Item, index) => {
              GridItem() {
                this.Item(item)
              }
            })

          }
          .width(250)
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
        }

      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Auto)
      .scrollBarColor("#999")
      .scrollBarWidth(5)
      .edgeEffect(EdgeEffect.Fade)
      .margin({ top: 20 })

    }.width("90%").height(180)
  }
}