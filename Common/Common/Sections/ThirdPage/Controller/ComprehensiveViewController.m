//
//  ComprehensiveViewController.m
//  Common
//
//  Created by xsn on 2018/9/19.
//  Copyright © 2018年 . All rights reserved.
//

#import "ComprehensiveViewController.h"

@interface ComprehensiveViewController ()

@end

@implementation ComprehensiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addSegmentControlForNav];
}

- (void)addSegmentControlForNav {
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 8.0f, SCREEN_RECT.size.width, 30.0f) ];
    [segmentedControl insertSegmentWithTitle:@"综合查询" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"收藏" atIndex:0 animated:YES];
    //    segmentedControl.momentary = YES;
    //    segmentedControl.multipleTouchEnabled = NO;
    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = segButton;
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
