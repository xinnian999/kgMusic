import router from '@ohos.router';

@Entry
@Component
struct Welcome {
  @State message: string = 'Hello 酷狗';

  onDidBuild(): void {
    setTimeout(()=>{
      // router.pushUrl({ url:"pages/Index", params: null })
    },1500)
  }

  build() {
    Column(){
      Image($r('app.media.welcome'))

    }.width('100%').height('100%').backgroundColor('red')
  }


}