import { AVPlayerDemo } from './audio';
import router from '@ohos.router';

@Entry
@Component
struct Welcome {
  @State message: string = 'Hello 酷狗';

  async onDidBuild(): Promise<void> {
    const player = new AVPlayerDemo()
    player.avPlayerResFileDemo()
    player.avPlayerLiveDemo()

    setTimeout(() => {

      router.pushUrl({ url: "pages/Index", params: null })
    }, 1000)
  }

  build() {
    Column() {
      Image($r('app.media.welcome'))

    }.width('100%').height('100%').backgroundColor('#00a7fe')
  }
}