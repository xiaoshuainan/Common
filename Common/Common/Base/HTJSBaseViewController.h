//
//  HTJSBaseViewController.h
//  Common
//
//  Created by 效帅楠 on 2017/4/11.
//  Copyright © 2017年 河南航天金穗电子有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface HTJSBaseViewController : UIViewController

@property(nonatomic,assign) NSInteger pageIndex;

#pragma mark 界面切换

//不需要传参数的push 只需告诉类名字符串
- (void)pushViewControllerWithName:(id)classOrName;
//回到当前模块导航下的某一个页面
- (void)returnViewControllerWithName:(id)classOrName;
//切到指定模块下
- (void)popToHomePageWithTabIndex:(NSInteger)index completion:(void (^)(void))completion;

#pragma mark 左边按钮定制

/**
 *  显示默认返回按钮
 *
 *  @param title 需要传入上级界面标题
 */
- (void)showBackWithTitle:(NSString *)title;

/**
 *  自定义左边按钮
 *
 *  @param icon     图标 非必填
 *  @param title    标题 非必填
 *  @param selector 事件
 */
- (void)setLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;
- (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;

#pragma mark 右边按钮定制

/**
 *  通过文字设置右侧导航按钮
 *
 *  @param title    文字
 *  @param selector 事件
 */
- (void)setRightItemWithTitle:(NSString *)title selector:(SEL)selector;
- (UIBarButtonItem *)ittemRightItemWithTitle:(NSString *)title selector:(SEL)selector;

/**
 *  通过ico定制右侧按钮
 *
 *  @param icon     图标
 *  @param selector 事件
 */
- (void)setRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;
- (UIBarButtonItem *)ittemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector;

#pragma mark titleView定制

//设置纯文字titleVIew
- (void)setNavigationItemTitleViewWithTitle:(NSString *)title;

#pragma mark - 小红点

/**
 *  小红点View定制
 *
 *  @param redDotValue <#redDotValue description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)ittemRedViewWithRedDotValue:(NSString *)redDotValue;

#pragma mark - MJRefresh
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header;
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer;
- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer;

@end
