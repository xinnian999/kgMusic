import Menus from './menus'
import type { Item } from './menus'
import router from '@ohos.router'
import request from '../../../api/request'
import { AxiosResponse } from '@ohos/axios'
import AudioRow from '../../../components/AudioRow'
import { HotAudioItem } from '../../../interface'
import { AudioRowItem } from '../../../interface/components'
import PlayList from '../../../components/playList'
import PlayBar from '../../../components/PlayBar'

@Component
export default struct My {
  @State songList: HotAudioItem[] = []
  @State isLoading: boolean = false

  async fetchSongList() {
    this.isLoading = true
    const res: AxiosResponse = await request(`/top/card?card_id=3&timestamp=${Date.now()}`)
    this.songList = res.data.data.song_list
    this.isLoading = false

  }

  async onDidBuild() {
    this.fetchSongList()
  }

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
        router.replaceUrl({ url: data.to, params: null })
      }
    })
  }

  build() {
    Scroll() {
      Column() {
        TextInput({ placeholder: '输入关键词搜索歌曲...' })
          .height(40)
          .onClick(() => router.pushUrl({ url: "pages/SearchPage" }))

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
        .height(180)

        Column() {
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            Text('热歌推荐')
            Image($r('app.media.refresh'))
              .width(18)
              .height(18)
              .rotate({ angle: this.isLoading ? 360 : 0 })
              .animation({
                duration: 700,
              })
              .onClick(this.fetchSongList.bind(this))
          }


          PlayList({
            dataSource: this.songList.map<AudioRowItem>(v => ({
              aid: v.songid,
              name: v.songname,
              author: v.author_name,
              hash: v.hash,
              albumId: v.album_id,
              avatar: ''
            }))
          })
        }
        .width('100%')
        .margin({ top: 20 })
        .alignItems(HorizontalAlign.Start)

      }.width("90%")
    }
    .width("100%")
    .scrollBar(BarState.Auto)
    .scrollBarColor("#999")
    .scrollBarWidth(5)
    .edgeEffect(EdgeEffect.Fade)

  }
}