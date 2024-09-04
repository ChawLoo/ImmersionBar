import { window } from '@kit.ArkUI'

export class ImmersionBarUtils {
  windowClass: window.Window | null = null
  private statusBarHeight: number = 0
  private navigationBarHeight: number = 0
  private navigationIndicatorHeight: number = 0

  getStatusBarHeight(): number {
    return this.statusBarHeight
  }

  getNavigationBarHeight(): number {
    return this.navigationBarHeight
  }

  getNavigationIndicatorHeight(): number {
    return this.navigationIndicatorHeight
  }

  getNavigationHeight(): number {
    return this.navigationBarHeight > this.navigationIndicatorHeight ? this.navigationBarHeight : this.navigationIndicatorHeight
  }

  fullScreen(isFullScreen: boolean = true) {
    if (canIUse('SystemCapability.Window.SessionManager')) {
      this.windowClass?.setSpecificSystemBarEnabled('status', !isFullScreen)
      this.windowClass?.setSpecificSystemBarEnabled('navigation', !isFullScreen)
    }
  }

  hideNavigation(isHide: boolean = true) {
    if (canIUse('SystemCapability.Window.SessionManager')) {
      this.windowClass?.setSpecificSystemBarEnabled('navigation', !isHide)
    }
  }

  hideStatusBar(isHide: boolean = true) {
    if (canIUse('SystemCapability.Window.SessionManager')) {
      this.windowClass?.setSpecificSystemBarEnabled('status', !isHide)
    }
  }

  init(w: window.Window) {
    this.windowClass = w
    this.statusBarHeight = px2vp(w.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height)
    this.navigationIndicatorHeight = px2vp(w.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height)
    this.navigationBarHeight = px2vp(w.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).bottomRect.height)
  }

  /**
   * 如果 transparentStatusBar
   * @param value
   */
  immersion(value: ImmersionBarSettings) {
    let isLayoutFullScreen: boolean = value.transparentStatusBar ?? false
    this.windowClass?.setImmersiveModeEnabledState(isLayoutFullScreen)
    let statusBarColor = value.statusBarColor
    if (value.transparentStatusBar) {
      statusBarColor = Color.Transparent.toString()
    }
    if (value.statusBarColor) {
      statusBarColor = value.statusBarColor
    }
    let sysBarProps: window.SystemBarProperties = {
      statusBarColor: statusBarColor,
      statusBarContentColor: value.statusBarContentColor,
      navigationBarColor: value.navigationBarColor,
      navigationBarContentColor: value.navigationBarContentColor
    }
    this.windowClass?.setWindowSystemBarProperties(sysBarProps)
  }
}

export interface ImmersionBarSettings {
  transparentStatusBar?: boolean,
  statusBarColor?: string,
  statusBarContentColor?: string,
  navigationBarColor?: string,
  navigationBarContentColor?: string,
  fullScreen?: boolean,
}