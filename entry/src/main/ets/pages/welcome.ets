import router from '@ohos.router';
import { AVPlayerDemo } from './audio';

@Entry
@Component
struct Welcome {
  @State message: string = 'Hello 酷狗';

  onDidBuild(): void {
    const player = new AVPlayerDemo()
    player.avPlayerUrlDemo()
    setTimeout(() => {
      router.pushUrl({ url: "pages/Index", params: null })
    }, 150000)
  }

  build() {
    Column() {
      Image($r('app.media.welcome'))

    }.width('100%').height('100%').backgroundColor('#00a7fe')
  }
}