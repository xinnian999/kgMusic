import { loginApi } from '../../../../api/login';

@Component
export default  struct PasswordLogin {
  @State private username: string = '';
  @State private password: string = '';
  

  private async handleSubmit() {
    const res = await loginApi(this.username, this.password)
    AlertDialog.show({ message: '登陆成功' })
    // console.log(res.cookies)
    // const cookies = (res.header['set-cookie'] as string[]).map(item => item.split(';')[0]).join(';')
    // AppStorage.setOrCreate('kgCookie', cookies)
  }


  build() {
    Column({space:30}){
      Column({ space: 20 }) {
        TextInput({ placeholder: '请输入手机号' }).onChange((value: string) => {
          this.username = value;
        })

        TextInput({ placeholder: '请输入密码' }).type(InputType.Password).onChange((value: string) => {
          this.password = value;
        })
      }
      .width('70%')

      Column() {
        Row({ space: 10 }) {

          Button('登陆').onClick(this.handleSubmit.bind(this))
        }

      }
    }

  }
}