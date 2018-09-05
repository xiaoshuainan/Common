//
//  BaseTabBarViewController.m
//  Common
//
//  Created by xsn on 2018/9/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "UITabBar+Badge.h"
#import "UIImage+Extension.h"

@interface BaseTabBarViewController ()

@property (nonatomic,assign) NSInteger index;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewControllers];
}

//- (void)viewWillLayoutSubviews {
//    float height = 50;
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = height;
//    tabFrame.origin.y = self.view.frame.size.height - height;
//    self.tabBar.frame = tabFrame;
//}

#pragma mark - 初始化数据源
- (void)setViewControllers {
    //UITabBarController 数据源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarConfigure" ofType:@"plist"];
    NSArray *dataAry = [[NSArray alloc] initWithContentsOfFile:path];
    for (NSDictionary *dataDic in dataAry) {
        //每个tabar的数据
        Class classs = NSClassFromString(dataDic[@"class"]);
        NSString *title = dataDic[@"title"];
        NSString *imageName = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        NSString *badgeValue = dataDic[@"badgeValue"];
        
        [self addChildViewController:[self ittemChildViewController:classs title:title imageName:imageName selectedImage:selectedImage badgeValue:badgeValue]];
    }
}

- (BaseNavigationViewController *)ittemChildViewController:(Class)classs title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage badgeValue:(NSString *)badgeValue {
    UIViewController *vc = [classs new];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[[UIImage imageNamed:selectedImage] imageToColor:kUIToneBackgroundColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //起点-8图标才会到顶，然后加上计算出来的y坐标
    float origin = -9 + 6;
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(-2 + 8, 2-8);
    //title设置
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kUIToneBackgroundColor,NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    vc.tabBarItem.title = title;
    
    //小红点
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
    //导航
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.navigationBar.topItem.title = title;
    [nav.rootVcAry addObject:classs];
    return nav;
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (index != _index) {
        [self openItemAnimationWithIndex:index];
        _index = index;
    }
}

#pragma mark - 设置点击动画
/**
 开启tabBar动画
 
 @param index tabBar下标
 */
- (void)openItemAnimationWithIndex:(NSInteger)index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton.subviews.firstObject];
        }
    }
    /**
     CABasicAnimation类的使用方式就是基本的关键帧动画。
     所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
     */
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.9];
    pulse.toValue = [NSNumber numberWithFloat:1.1];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

#pragma mark - 角标

/**
 设置指定tabar角标
 
 @param badgeValue 小红点的值
 @param index tabBar下标
 */
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index {
    if (index + 1 > self.viewControllers.count || index < 0) {
        //越界或者数据异常直接返回
        return;
    }
    BaseNavigationViewController *base = self.viewControllers[index];
    if (base.viewControllers.count == 0) {
        return;
    }
    UIViewController *vc = base.viewControllers[0];
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
}

/**
 显示tabBar角标
 
 @param index tabBar下标
 */
- (void)showBadgeWithIndex:(NSInteger)index {
    [self.tabBar showBadgeOnItemIndex:index];
}

/**
 显示tabBar角标
 
 @param index tabBar下标
 */
- (void)hideBadgeWithIndex:(NSInteger)index {
    [self.tabBar hideBadgeOnItemIndex:index];
}

#pragma mark - 去掉tabBar顶部线条
/**
 隐藏tabBar顶部线条 (默认显示线条)
 */
- (void)removeTabarTopLine {
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
