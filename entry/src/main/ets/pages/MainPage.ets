import immersionBar from 'ImmersionBar/ImmersionBar'

@Component
export default struct MainPage {
  @State @Watch('changeImmersionBar') isTransparentBar: boolean = false
  @State statusBarColor: string = '#00000000'
  @State statusBarContentColor: string = '000000'

  changeImmersionBar() {
    immersionBar.immersion({
      transparentStatusBar: this.isTransparentBar,
    })
  }

  build() {
    Column() {
      Image($r("app.media.ic_image_sample_1"))
        .width('100%')
      Text(`状态栏高度：${immersionBar.getStatusBarHeight()}`)
      Text(`导航栏高度：${immersionBar.getNavigationBarHeight()}`)
      Text(`导航条高度：${immersionBar.getNavigationIndicatorHeight()}`)
      Row() {
        Text('是否开启沉浸式（不是隐藏状态栏的全屏）')
        Toggle({
          type: ToggleType.Switch,
          isOn: this.isTransparentBar
        }).onChange((isOn) => {
          this.isTransparentBar = isOn
        })
      }
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }
}