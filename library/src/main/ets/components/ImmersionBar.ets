import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import { hilog } from '@kit.PerformanceAnalysisKit'

export class ImmersionBarUtils {
  windowClass: window.Window | null = null

  init(window: window.Window) {
    hilog.info(0x000, 'ChawLoo', '%{public}s', '初始化ImmersionBar')
    this.windowClass = window
  }

  immersion(value: ImmersionBarSettings) {
    let isLayoutFullScreen = value.transparentStatusBar
    this.windowClass?.setWindowLayoutFullScreen(isLayoutFullScreen, (err: BusinessError) => {
      if (err.code) {
        hilog.error(0x000, 'ChawLoo', '%{public}s', `Failed to set the window layout to full-screen mode. Cause:${JSON.stringify(err)}`)
        return
      }
      hilog.info(0x000, 'ChawLoo', '%{public}s', `Successed in setting the window layout to full-screen mode.`)
    })
    let sysBarProps: window.SystemBarProperties = {
      statusBarColor: value.statusBarColor,
      statusBarContentColor: value.statusBarContentColor,
      navigationBarColor: value.navigationBarColor,
      navigationBarContentColor: value.navigationBarContentColor
    }
    this.windowClass?.setWindowSystemBarProperties(sysBarProps, (err) => {
      if (err.code) {
        hilog.error(0x000, 'ChawLoo', '%{public}s', `Failed to set the system bar properties. Cause:${JSON.stringify(err)}`)
        return
      }
      hilog.info(0x000, 'ChawLoo', '%{public}s', "Succeeded in setting the system bar properties.")
    })
  }
}

export interface ImmersionBarSettings {
  transparentStatusBar?: boolean,
  statusBarColor?: string,
  statusBarContentColor?: string,
  navigationBarColor?: string,
  navigationBarContentColor?: string,
}