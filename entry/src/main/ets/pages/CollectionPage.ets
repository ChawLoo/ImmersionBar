import { router } from '@kit.ArkUI'

@ComponentV2
export default struct CollectionPage {
  build() {
    Column() {
      Button('Collection Page')
        .type(ButtonType.Capsule)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .align(Alignment.Center)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ExpandedPage'
          })
        })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}