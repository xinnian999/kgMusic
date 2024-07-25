import { AxiosResponse } from '@ohos/axios';
import request from '../api/request';
import { media } from '@kit.MediaKit';
import { getMusicUrlApi, getLyricIdApi, getLyricApi } from '../api/getUrl';
import { AVPlayerDemo } from '../utils/audio';
import Playing from './Playing';
import { AudioRowItem } from '../interface/components';

@Component
export default struct AudioRow {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '';
  @StorageLink('authorName') authorName: string = '';
  @StorageLink('audioAvatar') audioAvatar: string | undefined = '';
  @StorageLink('audioDuration') audioDuration: number = 0;
  @StorageLink('audioLyric') audioLyric: string = '';
  @StorageLink('playing') playing: boolean = false;
  // @StorageProp('playList') playList:=[]
  @Prop data: AudioRowItem = {
    aid: 0,
    name: '歌名',
    author: '演唱者',
    albumId: 0,
    hash: ''
  }
  @State avatar: string = ''

  async onDidBuild() {
    const res: AxiosResponse = await request(`/album?album_id=${this.data.albumId}`)
    this.avatar = res.data.data[0].sizable_cover.replace('\{size\}', 120)
  }

  async handlePlay() {
    if (this.data.aid === this.audioId) {

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

      //获取歌词
      const lyricIdRes: AxiosResponse = await getLyricIdApi(this.data.hash)
      const lyricRes: AxiosResponse =
        await getLyricApi(lyricIdRes.data.candidates[0].id, lyricIdRes.data.candidates[0].accesskey)
      this.audioLyric = lyricRes.data.decodeContent

      const urlRes: AxiosResponse = await getMusicUrlApi(this.data.hash)
      // console.log(JSON.stringify(urlRes))
      const url: string = urlRes.data.url[0]
      this.audio = await new AVPlayerDemo().avPlayerLiveDemo(url)
      this.audioId = this.data.aid
      this.audioName = this.data.name
      this.authorName = this.data.author
      this.audioAvatar = this.avatar
      this.audioDuration = urlRes.data.std_hash_time
      this.playing = true

    }
  }

  build() {

    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Column() {
          Image(this.avatar)
            .borderRadius(8)
          if (this.data.aid === this.audioId) {
            Column() {
              Column() {
                Playing()
              }
              .width('50%')
              .height('50%')
              .position({ left: '50%', top: '50%' })
              .markAnchor({ x: '50%', y: '50%' })
            }
            .width('100%')
            .height('100%')
            .backgroundColor("rgba(0,0,0,0.3)")
            .borderRadius(8)
            .position({ left: 0, top: 0 })

          }
        }
        .width(50)
        .height(50)

        Column() {
          Text(this.data.name)
            .margin({ bottom: 10 })
            .fontColor(this.data.aid === this.audioId ? '#3d98ff' : '')
          Text(`${this.data.author}`).fontSize(13).fontColor('#999')
            .fontColor(this.data.aid === this.audioId ? '#3d98ff' : '')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 15 })
      }
      .height(80)
      .onClick(this.handlePlay.bind(this))

    }

  }
}