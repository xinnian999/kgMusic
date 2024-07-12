import { codeLoginApi, sendCodeApi } from '../../api/login';
import { router } from '@kit.ArkUI';
import { AxiosResponse } from '@ohos/axios';


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
    await sendCodeApi(this.username)
    // console.log(JSON.stringify(res.result))
    AlertDialog.show({ message: '验证码已发送' })
  }

  private async handleSubmit() {
    const res: AxiosResponse = await codeLoginApi(this.username, this.code)
    AlertDialog.show({ message: '登陆成功' })

    AppStorage.setOrCreate('userInfo', res.data)

    router.pushUrl({ url: 'pages/Index/index' })
  }
}