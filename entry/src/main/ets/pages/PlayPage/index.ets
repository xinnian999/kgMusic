import { media } from '@kit.MediaKit';
import parseLyric, { LyricItem } from './parseLyric'

interface ActionParams {
  icon: string
  onClick?: () => void
}

@Entry
@Component
export default struct PlayPage {
  @StorageLink('audio') audio: media.AVPlayer | null = null;
  @StorageLink('audioId') audioId: number = 0;
  @StorageLink('audioName') audioName: string = '歌名';
  @StorageLink('authorName') authorName: string = '歌手';
  @StorageLink('audioDuration') audioDuration: number = 0;
  @StorageLink('audioCurrentDuration') @Watch('currentDurationChange') audioCurrentDuration: number = 0;
  @StorageLink('audioAvatar') audioAvatar: string | undefined =
    'https://img1.baidu.com/it/u=147435362,3227015063&fm=253&fmt=auto&app=138&f=JPEG?w=565&h=855';
  @StorageLink('playing') @Watch('onChangePlaying') playing: boolean = false;
  @StorageLink('audioLyric') audioLyric: string = '';
  @State lyrics: LyricItem[] = []
  private scroll: Scroller = new Scroller();

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 300 })
      .slide(SlideEffect.Bottom)
    PageTransitionExit({ type: RouteType.Pop, duration: 300 })
      .slide(SlideEffect.Bottom)
  }

  onChangePlaying() {
    if (this.playing) {
      this.audio?.play()

    } else {
      this.audio?.pause()

    }
  }

  currentDurationChange() {
    const datas = parseLyric(this.audioLyric)
    const last = datas.filter(item => item.timestamp < this.audioCurrentDuration).pop()
    let lastIndex = 0
    this.lyrics = parseLyric(this.audioLyric).map((item, index) => {
      if (last?.timestamp === item.timestamp) {
        item.isCurrent = true
        lastIndex = index
      }
      return item
    })
    this.scroll.scrollToIndex(lastIndex, true, ScrollAlign.CENTER)
  }

  @Builder
  Action(params: ActionParams) {
    Image($r(`app.media.${params.icon}`))
      .width(30)
      .height(30)
      .onClick(params.onClick)
  }

  parseDuration(duration: number) {
    const toDuration = Math.floor(duration / 1000)
    const seconds = toDuration % 60
    const minutes = Math.floor(toDuration / 60)
    const right = seconds >= 10 ? seconds : `0${seconds}`
    const left = minutes >= 10 ? minutes : `0${minutes}`
    return `${left}:${right}`
  }

  onProgressClick(event: ClickEvent) {
    const newDuration = (event.x / (event.target.area.width as number)) * this.audioDuration
    console.log(newDuration + '');
    this.audio?.seek(newDuration)
  }

  build() {
    Column() {
      Column() {
        Image(this.audioAvatar).borderRadius(8).width(200).height(200).border({ width: 1, color: '#eee' })
      }.width("100%").alignItems(HorizontalAlign.Center).padding({ top: 50, bottom: 50 })

      //歌词
      List({ scroller: this.scroll, }) {
        ForEach(this.lyrics, (item: LyricItem) => {
          ListItem() {
            Text(item.lyric)
              .fontColor(item.isCurrent ? 'green' : '#ffefeeee')
              .height(40)
            // .blendMode(BlendMode.DST_IN, BlendApplyType.OFFSCREEN)
          }

          // .linearGradient({
          //
          //   direction: GradientDirection.Right,
          //
          //   colors: [[0xff0000, 0.0], [0xff0000, 0.3], [0x000000, 0.6], [0x000000, 1.0]]
          //
          // })
          // .blendMode(BlendMode.SRC_OVER, BlendApplyType.OFFSCREEN)

        })

      }
      .height(120)
      .margin({ top: 15, bottom: 60 })
      .alignListItem(ListItemAlign.Center)

      //歌曲信息
      Column() {
        Column({ space: 15 }) {
          Text(this.audioName)
            .fontWeight(700)
            .fontSize(20)
            .fontColor('#ffefeeee')
          Text(this.authorName)
            .fontColor('#ffefeeee')
        }
        .alignItems(HorizontalAlign.Start)
        .width("100%")

        //进度条
        Column() {
          Flex({ alignItems: ItemAlign.Center }) {
            Text(this.parseDuration(this.audioCurrentDuration))
              .width(70)
              .textAlign(TextAlign.Start)
              .fontColor('#ffefeeee')
            Column() {
              Column() {
                Row() {
                  Row()
                    .width(7)
                    .height(7)
                    .borderRadius(50)
                    .backgroundColor('#fff')
                    .margin({ left: '100%' })
                }
                .width(`${(this.audioCurrentDuration / this.audioDuration) * 100}%`)
                .height(2)
                .position({ left: 0 })
                .backgroundColor('#fff')
              }
              .height(2)
              .width('100%')
              .backgroundColor('#ffc4c2c2')
            }
            .height(10)
            .justifyContent(FlexAlign.Center)
            .onClick(this.onProgressClick.bind(this))


            Text(this.parseDuration(this.audioDuration))
              .width(70)
              .textAlign(TextAlign.End)
              .fontColor('#ffefeeee')
          }
        }
        .width("100%")
        .margin({ top: 50, bottom: 50 })

        Column() {
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            this.Action({ icon: 'audio_random' })
            this.Action({ icon: 'audio_prev' })
            this.Action({
              icon: this
                .playing
                ?
                'audio_pause' : 'audio_play',
              onClick: () => {
                this.playing = !this.playing
              }
            })
            this.Action({ icon: 'audio_next' })
            this.Action({ icon: 'audio_list' })
          }.width('100%')
        }
      }

    }
    .padding(20)
    .height('100%')
    .backgroundImage(this.audioAvatar)
    .backgroundImageSize(ImageSize.FILL)
    .backdropBlur(300)
    .backgroundEffect({ radius: 100, brightness: 0.8 })

  }
}