# Changelog

## [V1.1.0]
- ！！！重要的写前面，目前手头的mate60只有导航条，没有导航栏也改不了，无法测试，所有有问题提issue，我随时跟进
- 新增`getNavigationHeight()` 获取导航高度，导航条和导航栏取最大值
- 新增`fullScreen(isFullScreen:boolean = true)`全屏api，默认值为全屏，会隐藏状态栏和导航栏（条），实测导航条没有隐藏，但是官方提供了api，等后续版本看看，就像颜色修改失败一样。
- 举一反三，新增`hideNavigation(isHide: boolean = true)` 和 `hideStatusBar(isHide: boolean = true)`，效果字面意思，已知问题也同上。
- 开启沉浸式采用新api，`setImmersiveModeEnabledState`，已测没问题，效果一致
- beta5的状态栏颜色无法修改问题，官方回复升级beta6修复，跟框架无关，无需任何改动。

## [V1.0.9]
- 修复不设置【transparentStatusBar】值，崩溃问题，默认值为false

## [V1.0.8]
- 升级API，适配API12，注意API11就不知道能不能用，我看API是提示since 12，理论上应该不支持api12一下，慎重升级
- 使用上没有任何修改，仅升级底层API

## [V1.0.7]
- 升级API版本，测试下来也没啥问题，单纯升级底层

## [V1.0.6] 2024.05
- 透明状态栏后，默认颜色为透明色

## [V1.0.5] 2024.05
- 修复底部导航栏获取高度取错值问题 https://github.com/ChawLoo/ImmersionBar/issues/2

## [V1.0.4] 2024.05
- 新增example目录

## [V1.0.3] 2024.05
- 修改README.md的仓库地址为github地址

## [V1.0.2] 2024.05

- 完善Demo

## [v1.0.1] 2024.04

- 新增状态栏高度、导航栏高度和导航条高度
- 目前实测只有导航条，暂无导航栏，慎重使用

## [v1.0.0] 2024.04

- 发布1.0.0版本，实现简单状态栏和导航栏颜色修改
