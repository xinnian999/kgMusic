import { getMusicUrlApi } from '../../../api/getUrl';
import { loginApi, sendCodeApi } from '../../../api/login';


@Entry
@Component
struct Login {
  @State private username: string = '';
  @State private code: string = '';

  private async handleSendCode() {
    if (!this.username) {
      AlertDialog.show({ message: '请先输入手机号' })
      return
    }
    await sendCodeApi(this.username)
    AlertDialog.show({ message: '验证码已发送' })
  }

  private async handleSubmit() {
    const res = await loginApi(this.username, this.code)
    AlertDialog.show({ message: '登陆成功' })
    // console.log(res.cookies)
    const cookies = (res.header['set-cookie'] as string[]).map(item => item.split(';')[0]).join(';')
    AppStorage.setOrCreate('kgCookie', cookies)
  }

  private async handleGetUrl() {
    // AppStorage.set('')
    getMusicUrlApi('6D6BC2D6AE2B21943F810A2CD23E2260').then(res => {
      console.log(JSON.stringify(res))
    })
  }

  build() {
    RelativeContainer() {
      Column({ space: 30 }) {
        Text('登录酷狗音乐')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Column({ space: 20 }) {
          TextInput({ placeholder: '请输入手机号' }).onChange((value: string) => {
            this.username = value;
          })
          TextInput({ placeholder: '请输入验证码' }).onChange((value: string) => {
            this.code = value;
          })
        }
        .width('70%')

        Column() {
          Row({ space: 10 }) {
            Button('发送验证码').onClick(this.handleSendCode.bind(this))
            Button('登陆').onClick(this.handleSubmit.bind(this))
          }

          Button('测试获取歌曲URL').onClick(this.handleGetUrl.bind(this)).margin({ top: 30 })
        }
      }.alignRules({
        center: { anchor: '__container__', align: VerticalAlign.Center },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })

    }
    .height('100%')
    .width('100%')
  }
}