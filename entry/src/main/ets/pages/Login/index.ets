import { AxiosError, AxiosResponse } from '@ohos/axios';
import { getMusicUrlApi } from '../../api/getUrl';
import CodeLogin from './CodeLogin';
import PasswordLogin from './PasswordLogin';

PersistentStorage.persistProp('kgCookie', '12');
PersistentStorage.persistProp('userInfo', {});

@Entry
@Component
struct Login {
  @StorageLink('kgCookie') kgCookie: string = '0'

  build() {
    RelativeContainer() {


      Column({ space: 30 }) {
        // Text(this.kgCookie).fontSize(30)
        Text('登录酷狗音乐')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Tabs() {
          TabContent() {
            CodeLogin()
          }
          .tabBar('验证码登录')

          TabContent() {
            PasswordLogin()
          }.tabBar('密码登录')

        }.height('60%')

        // Button('测试获取歌曲URL').onClick(this.handleGetUrl.bind(this)).margin({ top: 30 })

      }.alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Center },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })

    }
    .height('100%')
    .width('100%')
  }

  private async handleGetUrl() {

    getMusicUrlApi('6D6BC2D6AE2B21943F810A2CD23E2260').then((res: AxiosResponse) => {
      console.log(JSON.stringify(res))

    }).catch((err: AxiosError) => {
      console.log('err', JSON.stringify(err))
    })

  }
}