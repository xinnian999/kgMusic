import { media } from '@kit.MediaKit';
import router from '@ohos.router';

@Component
export default struct PlayBar {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '';
  @StorageLink('authorName') authorName: string = '';
  @StorageLink('audioAvatar') audioAvatar: string | undefined = '';
  @StorageLink('playing') playing: boolean = false;

  handleSwitch() {
    if (this.playing) {
      this.audio?.pause()
      this.playing = false
    } else {
      this.audio?.play()
      this.playing = true
    }
  }

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
        Flex({ alignItems: ItemAlign.Center }) {
          Column() {
            Image(this.audioAvatar).borderRadius(8)
          }.width(50).height(50)

          Column() {
            Text(this.audioName)
              .margin({ bottom: 10 })
              .fontColor('#fff')
            Text(this.authorName).fontSize(13).fontColor('#ffe7e5e5')

          }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
        }


        Column() {
          Row() {
            Image(this.playing ? $r('app.media.audio_pause') : $r('app.media.audio_play'))
          }.width(20).height(20).margin({ right: 15 }).onClick(this.handleSwitch.bind(this))
        }

      }
      .borderRadius(8)
      .border({ width: 1, color: '#eee' })
      .width('95%')
      .height(60)
      .padding(5)
      .backgroundImage(this.audioAvatar)
      .backgroundImageSize(ImageSize.FILL)
      .backdropBlur(300)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .position({ top: '99%' })
    .markAnchor({ y: '100%' })
    .visibility(this.audioId ? Visibility.Visible : Visibility.Hidden)
    .onClick(() => {
      router.pushUrl({ url: "pages/PlayPage/index" })
    })
    .sharedTransition("bar", { duration: 3000 })
  }
}