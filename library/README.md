# ImmersionBar

## 简介

[ImmersionBar](https://github.com/ChawLoo/ImmersionBar.git) ，是一个针对HarmonyOS Next系统开发的沉浸式框架，采用官方底层API，简单、实用、高效。

- 修改状态栏颜色
- 修改状态栏文字图标颜色
- 修改导航栏颜色
- 修改导航栏图标颜色

## 下载安装

```javascript
ohpm install @chawloo/immersion-bar
```

OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.md)
## 重要的写前面
因为框架采用window来修改状态栏和颜色，那用navigation和router切换页面也不会更改window，所以页面切换不会更改之前设置的属性

如：RouterA设置了以下属性
```typescript
immersionBar.immersion({
  transparentStatusBar: false,//不开启沉浸式
  statusBarColor: '#987654',//修改状态栏颜色
  statusBarContentColor: '#456789'//修改状态栏系统图标等颜色
})
```
跳转RouterB后，仅设置以下属性
```typescript
immersionBar.immersion({
  transparentStatusBar: true,//开启沉浸式
})
```
⚠️由于没有重新设置状态栏颜色和状态栏系统图标等颜色，那他会沿用RouterA中的`'#987654'` 和 `'#456789'`这两个颜色⚠️

目前没有针对上一次的设置属性进行缓存，这个有待讨论，可以加也可以不加，大家可以提点建议
## 接口和属性列表
接口列表

| **接口**                                       | 参数                                  | 功能                                    |
|----------------------------------------------|-------------------------------------|---------------------------------------|
| init(window.Window)                          |                                     | 初始化                                   |
| immersionBar.immersion(ImmersionBarSettings) | [ImmersionBarSettings](#请求配置)：系统栏配置 | 设置系统栏                                 |
| immersionBar.getStatusBarHeight()            | 无                                   | 获取状态栏高度                               |
| immersionBar.getNavigationBarHeight()        | 无                                   | 获取导航栏高度                               |
| immersionBar.getNavigationIndicatorHeight()  | 无                                   | 获取导航条高度                               |
| immersionBar.getNavigationHeight()           | 无                                   | 获取导航高度（导航条和导航栏去最大值）                   |
| immersionBar.fullScreen()                    | 是否全屏：boolean,default:true           | 开启全屏（入参如果false，则为关闭）                  |
| immersionBar.hideNavigation()                | 是否隐藏：boolean,default:true           | 隐藏导航栏（条）（入参如果false，则为关闭），实测暂时无效，api问题 |
| immersionBar.hideStatusBar()                 | 是否隐藏：boolean,default:true           | 隐藏状态栏（入参如果false，则为关闭）                 |

属性列表

| **属性**                    | 类型      | 描述                                |
|---------------------------|---------|-----------------------------------|
| transparentStatusBar      | boolean | 是否透明状态栏（即是否全屏，此全屏非隐藏状态栏和系统栏，注意区分） |
| statusBarColor            | string  | 状态栏颜色，背景色(透明状态栏后，默认为透明色）          |
| statusBarContentColor     | string  | 状态栏内容颜色，即内部的系统图标颜色                |
| navigationBarColor        | string  | 导航栏颜色（导航条无法设置）                    |
| navigationBarContentColor | string  | 导航栏内容颜色（导航条或导航图标）                 |

## 使用示例

初始化，使用前切记一定要初始化框架，因为本项目采用window来进行修改颜色，需要传入window

```
//在EntryAbility的#onWindowStageCrate(windowStage:window.WindowStage)中初始化
export default class EntryAbility extends UIAbility {
  ...

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    //通过windowStage获取主window，如果获取失败也就无法修改了
    // windowStage.getMainWindow((err: BusinessError, data) => {
    //   const errCode: number = err.code
    //   if (errCode) {
    //     L.e(`Failed to obtain the main window. Cause:${JSON.stringify(err)}`)
    //     return
    //   }
    //   //初始化框架
    //   immersionBar.init(data)
    // })
    //或者可以同步获取window
    immersionBar.init(windowStage.getMainWindowSync())
    windowStage.loadContent('pages/main/RootPage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  ...
}

```



## 使用说明

### ImmersionBar API

#### 建议在对应页面的onPageShow()中设置，如果是Navigation，则在对应的onShown()设置
原因前面说过了，用的是同一个window，所以回来后要改成当前页面的状态，本框架只提供修改系统栏，至于在哪里设置都一样，什么方式设置都一样。

```typescript
  onPageShow(): void {
  immersionBar.immersion({
    statusBarColor: "#3369E7",
    statusBarContentColor: "#FFFFFF"
  })
}

NavDestination(){
  ···
}
.onShown(()=>{
  //每次进入都会调用
  immersionBar.immersion({
      ···
  })
})
```

如果想在Tabs中设置，则可以在其onChange通过索引或其他方式修改

```typescript
Tabs({ barPosition: BarPosition.End, controller: this.tabsController })
{
  ...
}
.
onChange((index) => {
  switch (index) {
    case 0: {
      immersionBar.immersion({
        statusBarColor: "#FFFFFF",
        statusBarContentColor: "#000000"
      })
      break;
    }
    case 4: {
      immersionBar.immersion({
        statusBarColor: "#3369E7",
        statusBarContentColor: "#FFFFFF"
      })
      break;
    }
    default: {
      immersionBar.immersion({
        statusBarColor: "#FFFFFF",
        statusBarContentColor: "#000000",
        transparentStatusBar: true
      })
      break;
    }
  }

  this.currentIndex = index
})
  .padding({ bottom: immersionBar.getNavigationIndicatorHeight() })
  .animationDuration(0)
  .scrollable(false)
  .barMode(BarMode.Fixed)
  .barWidth("100%")
```

## 约束与限制

在下述版本验证通过：
DevEco Studio NEXT Developer Beta5  (5.0.3.700), SDK: API12(5.0.0) 设备：Mate 60 Pro（beta5）

## FAQ
- 目前只是简单的设置，细节问题和更多功能正在研究和发掘开发，欢迎提交PR，共同进步

## 贡献代码

使用过程中发现任何问题都可以提[Issue](https://github.com/ChawLoo/ImmersionBar/issues) 给我们，当然，我们也非常欢迎你给我们提[PR](https://github.com/ChawLoo/ImmersionBar/pulls) 。

## 开源协议

本项目基于 [MIT](https://github.com/ChawLoo/ImmersionBar/blob/master/library/LICENSE) ，请自由地享受和参与开源。