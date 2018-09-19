//
//  HomeViewController.m
//  Common
//
//  Created by xsn on 2018/9/6.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self badgeSetting];
}

/**
 角标的设置
 */
- (void)badgeSetting {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.baseTabBar setBadgeValue:@"3" index:0];
    [delegate.baseTabBar setBadgeValue:@"嘿" index:2];
    [delegate.baseTabBar setBadgeValue:@"哈" index:3];
    [delegate.baseTabBar showBadgeWithIndex:1];
}

- (void)handleBtn:(UIButton *)btn {
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleModalBtn:(UIButton *)btn {
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

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
