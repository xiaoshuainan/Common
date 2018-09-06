//
//  HomeViewController.m
//  Common
//
//  Created by xsn on 2018/9/6.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface HomeViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl; //页面头部的segmentedControl

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self segmentedControl];
    
    [self badgeSetting];
}

#pragma mark - 自定义segmentedControl
/**
 添加自定义segmentedControl

 @return segmentedControl
 */
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"涉税", @"综合查询", @"公众服务", @"涉税事", @"查询", @"公众",]];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.frame = CGRectMake(0, 0, kScreenWidth, 50);
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        //选中状态颜色
        UIColor *selectedColor = [UIColor orangeColor];
        UIColor *unselectedColor = [UIColor blackColor];
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            if (selected) {
                //选中状态下,字体颜色与大小
                NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : selectedColor, NSFontAttributeName : [UIFont systemFontOfSize:15]}];
                return attString;
            } else {
                //未选中状态下,字体颜色与大小
                NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : unselectedColor, NSFontAttributeName : [UIFont systemFontOfSize:15]}];
                return attString;
            }
            return nil;
        }];
        //设置segmentedControl底部平移条
        _segmentedControl.selectionIndicatorColor = selectedColor;
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
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


- (void)addSegmentControlForNav {
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 8.0f, SCREEN_RECT.size.width, 30.0f) ];
    [segmentedControl insertSegmentWithTitle:@"公众服务" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"申报缴税" atIndex:1 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"涉税事项" atIndex:2 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"综合查询" atIndex:3 animated:YES];
//    segmentedControl.momentary = YES;
//    segmentedControl.multipleTouchEnabled = NO;
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = segButton;
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
