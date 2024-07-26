import { AxiosResponse } from '@ohos/axios';
import request from '../api/request';
import { media } from '@kit.MediaKit';
import { getMusicUrlApi, getLyricIdApi, getLyricApi } from '../api/getUrl';
import { AVPlayerDemo } from '../utils/audio';
import Playing from './Playing';
import { AudioRowItem } from '../interface/components';
import { PlayData, playDataInit } from '../interface/globals';

@Component
export default struct AudioRow {
  @StorageLink('audioId') audioId: number = 0;
  @Prop data: AudioRowItem

  build() {

    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Column() {
          Image(this.data.avatar)
            .borderRadius(8)
          if (this.data.aid === this.audioId) {
            Column() {
              Column() {
                Playing()
              }
              .width('50%')
              .height('50%')
              .position({ left: '50%', top: '50%' })
              .markAnchor({ x: '50%', y: '50%' })
            }
            .width('100%')
            .height('100%')
            .backgroundColor("rgba(0,0,0,0.3)")
            .borderRadius(8)
            .position({ left: 0, top: 0 })

          }
        }
        .width(50)
        .height(50)

        Column() {
          Text(this.data.name)
            .margin({ bottom: 10 })
            .fontColor(this.data.aid === this.audioId ? '#3d98ff' : '')
          Text(`${this.data.author}`).fontSize(13).fontColor('#999')
            .fontColor(this.data.aid === this.audioId ? '#3d98ff' : '')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 15 })
      }
      .height(80)

    }

  }
}