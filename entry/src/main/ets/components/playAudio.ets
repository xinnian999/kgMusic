import { media } from '@kit.MediaKit';
import { BusinessError } from '@kit.BasicServicesKit';

const fn = async (url: string, playIndex: number) => {
  let avPlayer: media.AVPlayer = await media.createAVPlayer();
  avPlayer.on('seekDone', (seekDoneTime: number) => {
    console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
  })
  avPlayer.on('timeUpdate', (time: number) => {
    AppStorage.setOrCreate('audioCurrentDuration', time)
    // console.info(`AVPlayer timeUpdate : ${time}`);
  })
  // error回调监听函数,当avPlayer在操作过程中出现错误时调用 reset接口触发重置流程
  avPlayer.on('error', (err: BusinessError) => {
    console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
    avPlayer.reset(); // 调用reset重置资源，触发idle状态
  })
  // 状态机变化回调函数
  avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
    switch (state) {
      case 'idle': // 成功调用reset接口后触发该状态机上报
        console.info('AVPlayer state idle called.');
        avPlayer.release(); // 调用release接口销毁实例对象
        AppStorage.setOrCreate('playIndex', playIndex + 1)
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
      // if (this.count !== 0) {
      //   if (this.isSeek) {
      //     console.info('AVPlayer start to seek.');
      //     avPlayer.seek(avPlayer.duration); //seek到音频末尾
      //   } else {
      //     // 当播放模式不支持seek操作时继续播放到结尾
      //     console.info('AVPlayer wait to play end.');
      //   }
      // } else {
      //   avPlayer.pause(); // 调用暂停接口暂停播放
      // }
      // this.count++;
        break;
      case 'paused': // pause成功调用后触发该状态机上报
        console.info('AVPlayer state paused called.');
      // avPlayer.play(); // 再次播放接口开始播放
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

  avPlayer.url = url;

  return avPlayer
}

export default fn