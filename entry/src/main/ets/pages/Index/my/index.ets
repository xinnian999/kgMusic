import { router } from '@kit.ArkUI'

@Component
export default struct My {
  @StorageLink('userInfo') userInfo: Record<string, string> = {}

  onDidBuild(): void {
    const userInfo = AppStorage.get<Record<string, string>>('userInfo')
    const kgCookie = AppStorage.get<string>('kgCookie')
    console.log('My', JSON.stringify(userInfo));
    console.log('kgCookie', kgCookie);

  }

  build() {
    Flex({ alignItems: ItemAlign.Center }) {
      Column() {
        Image(this.userInfo.pic || $r('app.media.user_avatar'))
      }.width(50).height(50)

      Column() {
        Text(this.userInfo.username || '立即登录').margin({ bottom: 10 })
        Text('登录后畅想精准歌曲推荐').fontSize(12).fontColor('#999')
      }.alignItems(HorizontalAlign.Start).margin({ left: 15 })
    }.height(100).padding(20).onClick(() => {
      router.pushUrl({ url: 'pages/Login/index' })
    })
  }
}