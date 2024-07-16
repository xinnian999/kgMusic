import { AxiosResponse } from '@ohos/axios';
import request from '../api/request';
import { media } from '@kit.MediaKit';
import { getMusicUrlApi } from '../api/getUrl';
import { AVPlayerDemo } from './audio';

@Component
export default struct AudioRow {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '';
  @StorageLink('authorName') authorName: string = '';
  @StorageLink('audioAvatar') audioAvatar: string | undefined = '';
  @StorageLink('audioDuration') audioDuration: number = 0;
  @StorageLink('playing') playing: boolean = false;
  @Prop aid: number = 0;
  @Prop name: string = '';
  @Prop author: string = '';
  @Prop albumId: number = 0;
  @Prop hash: string = '';
  @State avatar: string = ''

  async onDidBuild() {
    const res: AxiosResponse = await request(`/album?album_id=${this.albumId}`)
    this.avatar = res.data.data[0].sizable_cover.replace('\{size\}', 120)
  }

  async handlePlay() {
    if (this.aid === this.audioId) {
      if (this.playing) {
        this.audio?.pause()
        this.playing = false
      } else {
        this.audio?.play()
        this.playing = true
      }
    } else {
      // console.log('播放新歌曲')
      //先取消上一个audio
      this.audio?.release()

      const res: AxiosResponse = await getMusicUrlApi(this.hash)
      console.log('000', JSON.stringify(res.data))

      const url: string = res.data.url[0]
      this.audio = await new AVPlayerDemo().avPlayerLiveDemo(url)
      this.audioId = this.aid
      this.audioName = this.name
      this.authorName = this.author
      this.audioAvatar = this.avatar
      this.audioDuration = res.data.std_hash_time
      this.playing = true

    }
  }

  build() {

    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Column() {
          Image(this.avatar).borderRadius(8)
        }.width(50).height(50)

        Column() {
          Text(this.name)
            .margin({ bottom: 10 })
            .fontColor(this.aid === this.audioId ? '#3d98ff' : '')
          Text(`${this.name} - ${this.author}`).fontSize(13).fontColor('#999')
            .fontColor(this.aid === this.audioId ? '#3d98ff' : '')
        }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
      }
      .height(80)
      .onClick(this.handlePlay.bind(this))

    }

  }
}