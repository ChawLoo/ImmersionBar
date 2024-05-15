@Entry
@Component
export default struct MainPage {
  build() {
    Column() {
      Text('Main Page')
        .fontWeight(FontWeight.Bold)
        .fontSize(50)
        .align(Alignment.Center)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}