@Component
export default struct My {
  build() {
    Column() {
      TextInput({ placeholder: 'search...' })

        .height(40)
      Flex() {
        Column() {
          Text('每日推荐').fontColor('#fff')
          Text('精选30首').fontColor('#fff').fontSize(10).margin({ top: 10 })
        }
        .backgroundColor(Color.Brown)
        .height('100%')
        .width(120)
        .alignItems(HorizontalAlign.Start)
        .borderRadius(10)
        .padding(10)

        Grid() {
        
        }
      }.margin({ top: 20 })
    }.width("90%").height(180)
  }
}