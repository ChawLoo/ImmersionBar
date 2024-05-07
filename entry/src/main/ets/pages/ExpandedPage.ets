import immersionBar from 'ImmersionBar/ImmersionBar'

@Entry
@Component
struct ExpandedPage {
  aboutToAppear(): void {
    immersionBar.immersion({
      transparentStatusBar: false,
      statusBarColor: '#00000000',
      statusBarContentColor: '#FFFFFF'
    })
  }

  build() {
    Column() {
      Image($r("app.media.ic_image_sample_2"))
        .width('100%')
        .fitOriginalSize(true)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      Text('非沉浸式下扩展到系统栏，如果给这个文本组件的margin设置一个大一点值，能把图片顶出导航条，系统Bug？')
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
      Blank()
        .layoutWeight(1)
      Image($r('app.media.ic_image_sample_1'))
        .width('100%')
        .fitOriginalSize(true)
        .align(Alignment.Bottom)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height('100%')
    .align(Alignment.Top)
    .justifyContent(FlexAlign.Start)
  }
}