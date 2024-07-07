import { codeLoginApi, sendCodeApi } from '../../../../api/login';
import { router } from '@kit.ArkUI';


@Component
export default struct CodeLogin {
  @State private username: string = '';
  @State private code: string = '';

  build() {
    Column({ space: 30 }) {
      Column({ space: 20 }) {
        TextInput({ placeholder: '请输入手机号' }).onChange((value: string) => {
          this.username = value;
        })

        Flex({ alignItems: ItemAlign.Center, }) {
          TextInput({ placeholder: '请输入验证码' }).onChange((value: string) => {
            this.code = value;
          })
          Button('发送验证码')
            .size({ width: 150, height: 30 })
            .margin({ left: 10 })
            .onClick(this.handleSendCode.bind(this))
        }
      }
      .width('70%')

      Column() {
        Row({ space: 10 }) {

          Button('登陆').onClick(this.handleSubmit.bind(this))
        }

      }
    }

  }

  private async handleSendCode() {
    if (!this.username) {
      AlertDialog.show({ message: '请先输入手机号' })
      return
    }
    const res = await sendCodeApi(this.username)
    console.log(JSON.stringify(res.result))
    AlertDialog.show({ message: '验证码已发送' })
  }

  private async handleSubmit() {
    const res = await codeLoginApi(this.username, this.code)
    AlertDialog.show({ message: '登陆成功' })

    const cookies = (res.header['set-cookie'] as string[]).map(item => item.split(';')[0]).join('; ')
    const userInfo = res.result
    // console.log(typeof userInfo, JSON.parse(userInfo as string))

    AppStorage.setOrCreate('kgCookie', cookies)
    AppStorage.setOrCreate('userInfo', JSON.parse(userInfo as string).data)

    router.pushUrl({ url: 'pages/Index/index' })
  }
}