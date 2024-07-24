interface ItemParams {
  width: number
}

@Component
export default struct Playing {
  @State left: number = 100
  @State middle: number = 30
  @State right: number = 100

  onDidBuild(): void {
    this.left = 30
    this.right = 30
    this.middle = 100
  }

  @Builder
  Item(state: ItemParams) {
    Row()
      .height(`${state.width}%`)
      .width('20%')
      .backgroundColor('#fff')
      .borderRadius(10)
      .animation({
        duration: 700,
        curve: Curve.ExtremeDeceleration,
        delay: 0,
        iterations: -1, //-1 这里如果是-1表示无限循环
        tempo: 1,
        playMode: PlayMode.Alternate,
      })
  }

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      this.Item({ width: this.left })
      this.Item({ width: this.middle })
      this.Item({ width: this.right })
    }
    .height('100%')
    .width('100%')
  }
}