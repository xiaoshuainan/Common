//
//  AppConfig.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

typedef enum ServerType {
    ProductionMode = 0, //生产环境
    StagingMode = 1,    //预发布环境
    TestMode = 2,       //测试环境
} ServerType;

#define RELEASE_MODE 0 //appstore 改为0

//测试环境
#define kDebugSvrAddr @""
#define kDebugSvrPort 9000

//预发布环境
#define kPreReleaseSvrAddr @""
#define kPreReleaseSvrPort 8080

//正式环境
#define kReleaseSvrAddr @""
#define kReleaseSvrPort 80

//UI颜色控制
#define kUIToneBackgroundColor UIColorFromHex(0x00bd8c) //UI整体背景色调 与文字颜色一一对应
#define kUIToneTextColor UIColorFromHex(0xffffff) //UI整体文字色调 与背景颜色对应
#define kStatusBarStyle UIStatusBarStyleLightContent //状态栏样式
#define kViewBackgroundColor UIColorFromHex(0xf5f5f5) //界面View背景颜色

//延展
#import "NSString+Extension.h"
#import "UITabBar+Badge.h"
#import "UIImage+Extension.h"
#import "UIView+LoadNib.h"

#endif
