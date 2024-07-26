import { AudioRowItem } from '../interface/components'
import AudioRow from './AudioRow'
import { media } from '@kit.MediaKit';
import { AxiosResponse } from '@ohos/axios';
import { getLyricApi, getLyricIdApi, getMusicUrlApi } from '../api/getUrl';
import { AVPlayerDemo } from '../utils/audio';
import request from '../api/request';
import playAudio from './playAudio'

@Component
export default struct PlayList {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '';
  @StorageLink('authorName') authorName: string = '';
  @StorageLink('audioAvatar') audioAvatar: string | undefined = '';
  @StorageLink('audioDuration') audioDuration: number = 0;
  @StorageLink('audioLyric') audioLyric: string = '';
  @StorageLink('playing') playing: boolean = false;
  @StorageLink('playList') playList: AudioRowItem[] = []
  @StorageLink('playIndex') @Watch('onPlayIndexChange') playIndex: number = 999
  @Prop @Watch('fetchAvatar') dataSource: AudioRowItem[] = []
  @Prop list: AudioRowItem[] = []

  async fetchAvatar() {
    const reqs = this.dataSource.map(async item => {
      const res: AxiosResponse = await request(`/album?album_id=${item.albumId}`)
      item.avatar = res.data.data[0].sizable_cover.replace('\{size\}', 120)
      return item
    })
    this.list = await Promise.all(reqs)

  }

  async onPlayIndexChange() {
    // console.log('playIndex ' + this.playIndex)
    const current = this.list[this.playIndex]
    if (current.aid === this.audioId) {

      if (this.playing) {
        this.audio?.pause()
        this.playing = false
      } else {
        this.audio?.play()
        this.playing = true
      }
    } else {
      //先取消上一个audio
      this.audio?.release()


      //获取歌词
      const lyricIdRes: AxiosResponse = await getLyricIdApi(current.hash)
      const lyricRes: AxiosResponse =
        await getLyricApi(lyricIdRes.data.candidates[0].id, lyricIdRes.data.candidates[0].accesskey)
      this.audioLyric = lyricRes.data.decodeContent


      const urlRes: AxiosResponse = await getMusicUrlApi(current.hash)
      // console.log(JSON.stringify(urlRes))
      const url: string = urlRes.data.url[0]
      this.audio = await playAudio(url, this.playIndex)

      this.audioId = current.aid
      this.audioName = current.name
      this.authorName = current.author
      this.audioAvatar = current.avatar
      this.audioDuration = urlRes.data.std_hash_time
      this.playing = true
    }
  }

  build() {
    Column() {
      ForEach(this.list, (item: AudioRowItem, index: number) => {
        Column() {
          AudioRow({
            data: item
          })
        }
        .onClick(() => {
          this.playIndex = index
        })

      })
    }
  }
}