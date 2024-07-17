import { AVPlayerDemo } from '../utils/audio';
import router from '@ohos.router';

@Entry
@Component
struct Welcome {
  @State message: string = 'Hello 酷狗';

  async onDidBuild(): Promise<void> {
    setTimeout(() => {
      this.playMusic()
      router.pushUrl({ url: "pages/Index/index", params: null })
    }, 2000)
  }

  build() {
    Column() {
      Image($r('app.media.welcome'))
      // Button('播放music').onClick(this.playMusic).margin({ top: 300 })
    }.width('100%').height('100%').backgroundColor('#00a7fe')
  }

  private playMusic = () => {
    const player = new AVPlayerDemo()
    player.avPlayerResFileDemo()
    // player.avPlayerLiveDemo()
  }
}