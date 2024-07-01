import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello 酷狗';

  build() {
    RelativeContainer() {
      Column(){

        Column(){
          Text(this.message)
            .id('HelloWorld')
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .margin({bottom:30})
        }
        Column(){
          Button('登录').onClick(()=>{
            router.pushUrl({ url:"pages/Login/index", params: null })
          })
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