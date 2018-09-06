//
//  BaseTabBarViewController.h
//  Common
//
//  Created by xsn on 2018/9/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController

/**
 设置指定tabar角标(带数值小红点)

 @param badgeValue 小红点的值
 @param index tabBar下标
 */
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index;

/**
 显示tabBar角标(无数值小红点)

 @param index tabBar下标
 */
- (void)showBadgeWithIndex:(NSInteger)index;

/**
 隐藏tabBar角标(无数值小红点)

 @param index tabBar下标
 */
- (void)hideBadgeWithIndex:(NSInteger)index;

/**
 开启tabBar动画 (默认开启动画)

 @param index tabBar下标
 */
- (void)openItemAnimationWithIndex:(NSInteger)index;

/**
 隐藏tabBar顶部线条 (默认显示线条)
 */
- (void)removeTabarTopLine;

@end
