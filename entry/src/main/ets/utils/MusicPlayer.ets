import { media } from '@kit.MediaKit';
import { BusinessError } from '@kit.BasicServicesKit';

export interface MusicInfo {
  id: number
  name: string
  author: string
  albumId: number
  hash: string
  avatar?: string
  lyric: string
  duration: number
}

export class MusicPlayer {
  private static instance: MusicPlayer;
  audio: media.AVPlayer | undefined;
  playing: boolean = false;
  playData: MusicInfo = {
    id: 0,
    name: '歌名',
    author: '演唱者',
    albumId: 0,
    hash: '',
    avatar: '',
    lyric: '',
    duration: 0
  }

  constructor() {
    //单例模式
    if (MusicPlayer.instance) {
      return MusicPlayer.instance
    }

    this.init()
    MusicPlayer.instance = this
  }


  async init() {
    const avPlayer = await media.createAVPlayer();
    avPlayer.on('seekDone', (seekDoneTime: number) => {
      console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
    })
    avPlayer.on('timeUpdate', (time: number) => {
      AppStorage.setOrCreate('audioCurrentDuration', time)
      // console.info(`AVPlayer timeUpdate : ${time}`);
    })
    avPlayer.on('error', (err: BusinessError) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      avPlayer.reset(); // 调用reset重置资源，触发idle状态
    })
    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          console.info('AVPlayer state idle called.');
          avPlayer.release(); // 调用release接口销毁实例对象

        // this.playNext()
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('AVPlayer state initialized called.');
          avPlayer.prepare();
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('AVPlayer state prepared called.');
          avPlayer.play(); // 调用播放接口开始播放
          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('AVPlayer state playing called.');
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('AVPlayer state paused called.');
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('AVPlayer state completed called.');
          avPlayer.stop(); //调用播放结束接口
          AppStorage.setOrCreate('playing', false)
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('AVPlayer state stopped called.');
          avPlayer.reset(); // 调用reset接口初始化avplayer状态
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    })
    this.audio = avPlayer
  }
}