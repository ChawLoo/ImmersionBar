import immersionBar from 'ImmersionBar/ImmersionBar'

@ComponentV2
export default struct MainPage {
  @Param isTransparentBar: boolean = false
  @Event $isTransparentBar: (isTransparentBar: boolean) => void
  @Local statusBarColor: string = '#00000000'
  @Local statusBarContentColor: string = '000000'

  @Monitor('isTransparentBar')
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
      Text(`导航高度（两者取最大值）：${immersionBar.getNavigationHeight()}`)
      Row() {
        Text('是否开启沉浸式（不是隐藏状态栏的全屏）')
        Toggle({
          type: ToggleType.Switch,
          isOn: this.isTransparentBar
        }).onChange((isOn) => {
          this.$isTransparentBar(isOn)
        })
      }

      Row() {
        Text('是否全屏（隐藏系统栏）')
        Toggle({
          type: ToggleType.Switch,
        }).onChange((isOn) => {
          immersionBar.fullScreen(isOn)
        })
      }

      Row() {
        Text('隐藏状态栏')
        Toggle({
          type: ToggleType.Switch,
        }).onChange((isOn) => {
          immersionBar.hideStatusBar(isOn)
        })
      }

      Row() {
        Text('隐藏导航栏（暂时无效，非框架原因）')
        Toggle({
          type: ToggleType.Switch,
        }).onChange((isOn) => {
          immersionBar.hideNavigation(isOn)
        })
      }
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .height('100%')
    .width('100%')
  }
}