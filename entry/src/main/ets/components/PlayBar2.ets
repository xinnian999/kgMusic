import { media } from '@kit.MediaKit';
import router from '@ohos.router';
import { MusicPlayer } from '../utils';

@Component
export default struct PlayBar2 {
  @StorageProp('player') player: MusicPlayer = new MusicPlayer();

  handleSwitch() {
    if (this.player.playing) {
      this.player.audio!.pause()
      this.player.playing = false
    } else {
      this.player.audio?.play()
      this.player.playing = true
    }
  }

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
        Flex({ alignItems: ItemAlign.Center }) {
          Column() {
            Image(this.player.playData.avatar)
              .borderRadius(8)
          }
          .width(50)
          .height(50)

          Column() {
            Text(this.player.playData.name)
              .margin({ bottom: 10 })
              .fontColor('#fff')
            Text(this.player.playData.author)
              .fontSize(13)
              .fontColor('#ffe7e5e5')

          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 15 })
        }


        Column() {
          Row() {
            Image(this.player.playing ? $r('app.media.audio_pause') : $r('app.media.audio_play'))
          }
          .width(20)
          .height(20)
          .margin({ right: 15 })
          .onClick(this.handleSwitch.bind(this))
        }

      }
      .borderRadius(8)
      .border({ width: 1, color: '#eee' })
      .width('95%')
      .height(60)
      .padding(5)
      .backgroundImage(this.player.playData.avatar)
      .backgroundImageSize(ImageSize.FILL)
      .backdropBlur(300)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .position({ top: '99%' })
    .markAnchor({ y: '100%' })
    .visibility(this.player.playData.id ? Visibility.Visible : Visibility.Hidden)
    .onClick(() => {
      router.pushUrl({ url: "pages/PlayPage/index" }, router.RouterMode.Single)
    })
    .sharedTransition("PlayBar", { duration: 300 })
  }
}