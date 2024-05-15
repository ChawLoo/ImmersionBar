import MainPage from './MainPage'
import MinePage from './MinePage'
import CollectionPage from './CollectionPage'
import immersionBar from 'ImmersionBar/ImmersionBar'

@Entry
@Component
export default struct Index {
  @State currentIndex: number = 0
  private tabsController = new TabsController()

  @Builder
  TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
      Text(title)
        .fontColor(this.currentIndex === index ? Color.Blue : Color.Gray)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .fontSize(this.currentIndex === index ? 14 : 12)
        .margin({ top: 3 })
    }
    .padding({ top: 3, bottom: 3 })
    .width('100%')
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        MainPage()
      }
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.tab_home_sel'), $r('app.media.tab_home')))

      TabContent() {
        CollectionPage()
      }
      .tabBar(this.TabBuilder('收藏', 1, $r('app.media.tab_collection_sel'), $r('app.media.tab_collection')))

      TabContent() {
        MinePage()
      }
      .tabBar(this.TabBuilder('我的', 2, $r('app.media.tab_mine_sel'), $r('app.media.tab_mine')))
    }
    .onChange((index) => {
      this.currentIndex = index
      switch (index) {
        case 0:
          immersionBar.immersion({
            transparentStatusBar: false,
            statusBarColor: '#987654',
            statusBarContentColor: '#456789'
          })
          break
        case 1:
          immersionBar.immersion({
            transparentStatusBar: false,
            statusBarColor: "#00000000",
            statusBarContentColor: '#000000'
          })
          break
        default:
          immersionBar.immersion({
            transparentStatusBar: true,
            statusBarColor: '#229933',
            statusBarContentColor: '#11FF22'
          })
          break
      }
    })
    .padding({ bottom: immersionBar.getNavigationIndicatorHeight() })
    .animationDuration(0)
    .scrollable(false)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
  }
}