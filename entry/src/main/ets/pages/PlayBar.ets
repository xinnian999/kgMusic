import { media } from '@kit.MediaKit';

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
            Text(this.authorName).fontSize(13).fontColor('#999')

          }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
        }


        Column() {
          Row() {
            Image(this.playing ? $r('app.media.pause') : $r('app.media.play'))
          }.width(20).height(20).margin({ right: 15 }).onClick(this.handleSwitch.bind(this))
        }

      }
      .borderRadius(8)
      .border({ width: 1, color: '#eee' })
      .backgroundColor('#fff')
      .width('95%')
      .height(60)
      .padding(5)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .position({ top: '99%' })
    .markAnchor({ y: '100%' })
    .visibility(this.audioId ? Visibility.Visible : Visibility.Hidden)
  }
}