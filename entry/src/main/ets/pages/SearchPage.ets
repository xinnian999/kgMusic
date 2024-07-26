import router from '@ohos.router'
import { AxiosResponse } from '@ohos/axios'
import request from '../api/request'
import AudioRow from '../components/AudioRow'

interface SongType {
  SongName: string
  SingerName: string
  Image: string
  FileHash: string
  ID: string
  AlbumID: string
}

@Entry
@Component
export default struct SearchPage {
  @State private q: string = ''
  @State private songs: SongType[] = []

  async handleSearch() {
    const res: AxiosResponse = await request(`/search/complex?keywords=${this.q}`)
    this.songs = res.data.data.lists[0].lists
  }

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Image($r('app.media.back'))
          .width(30)
          .onClick(() => router.back())

        TextInput({ placeholder: '输入关键词搜索歌曲...' })
          .height(40)
          .margin({ left: 10, right: 10 })
          .onChange((val: string) => {
            this.q = val
          })

        Text('搜索').width(40).onClick(this.handleSearch.bind(this))
      }

      ForEach(this.songs, (item: SongType, index) => {
        AudioRow({
          data: {
            aid: Number(item.ID),
            name: item.SongName,
            author: item.SingerName,
            hash: item.FileHash,
            albumId: Number(item.AlbumID),
            avatar:''
          }
        })
      })
    }.padding(15)

  }
}