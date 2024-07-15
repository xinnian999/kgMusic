import { media } from '@kit.MediaKit';

@Entry
@Component
export default struct PlayPage {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '歌名';
  @StorageLink('authorName') authorName: string = '歌手';
  @StorageLink('audioAvatar') audioAvatar: string | undefined = '';
  @StorageLink('playing') playing: boolean = false;

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 300 })
      .slide(SlideEffect.Bottom)
    PageTransitionExit({ type: RouteType.Pop, duration: 300 })
      .slide(SlideEffect.Bottom)
  }

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
      Column() {
        Image(this.audioAvatar).borderRadius(8).width(200).height(200).border({ width: 1, color: '#eee' })
      }.width("100%").alignItems(HorizontalAlign.Center).padding({ top: 50, bottom: 50 })

      Column() {
        Text('歌词')
      }.width("100%").alignItems(HorizontalAlign.Center).padding({ top: 20, bottom: 60 })

      Column() {
        Column({ space: 15 }) {
          Text(this.audioName)
            .fontWeight(700)
            .fontSize(20)
            .fontColor('#ffefeeee')
          Text(this.authorName)
            .fontColor('#ffefeeee')
        }.alignItems(HorizontalAlign.Start).width("100%")

        Column() {
          Flex({ alignItems: ItemAlign.Center }) {
            Text('00:00')
              .width(70)
              .textAlign(TextAlign.Start)
              .fontColor('#ffefeeee')
            Column() {

            }
            .height(2)
            .width('100%')
            .backgroundColor('#eee')

            Text('00:00')
              .width(70)
              .textAlign(TextAlign.End)
              .fontColor('#ffefeeee')
          }
        }
        .width("100%")
        .margin({ top: 50, bottom: 50 })

        Column() {
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            Image($r('app.media.audio_random'))
              .width(20)
              .height(20)
              .margin({ right: 15 })
            Image($r('app.media.audio_prev'))
              .width(30)
              .height(30)
              .margin({ right: 15 })
            Image(this.playing ? $r('app.media.audio_pause') : $r('app.media.audio_play'))
              .width(30)
              .height(30)
              .margin({ right: 15 })
              .onClick(this.handleSwitch.bind(this))
            Image($r('app.media.audio_next'))
              .width(30)
              .height(30)
              .margin({ right: 15 })
            Image($r('app.media.audio_random'))
              .width(20)
              .height(20)
              .margin({ right: 15 })
          }.width('100%')
        }
      }

    }
    .padding(20)
    .height('100%')
    .backgroundImage(this.audioAvatar)
    .backgroundImageSize(ImageSize.FILL)
    .backdropBlur(300)

  }
}