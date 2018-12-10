//
//  MenuViewController.m
//  Common
//
//  Created by xsn on 2018/9/19.
//  Copyright © 2018年 . All rights reserved.
//

#import "MenuViewController.h"
#import "CollectionReusableHeaderView.h"
#import "CollectionReusableFooterView.h"
#import "CategoryHomeShowAppCell.h"
#import "CategoryModel.h"
//自定义SegmentedControl
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface MenuViewController ()<UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *homeDataArray; //分区标题数组
@property (nonatomic, strong) NSMutableArray *groupArray;    //分区内容详情
@property (nonatomic, strong) UICollectionView *appCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong)HMSegmentedControl *segmentedControl; //页面头部的segmentedControl
@property (nonatomic, assign) NSInteger sectionIndex; //collectionView滑动的分区

@end

const CGFloat segmentControlH = 50;
const CGFloat navViewH = 64;
const CGFloat tabBarH = 49;

static NSString *const cellId = @"CategoryHomeShowAppCell";
static NSString *const headerId = @"CollectionReusableHeaderView";
static NSString *const footerId = @"CollectionReusableFooterView";

@implementation MenuViewController

#pragma mark - 懒加载数据源/视图
//MARK:初始化主菜单数据源
- (NSMutableArray *)homeDataArray{
    if (_homeDataArray == nil) {
        _homeDataArray = [NSMutableArray array];
    }
    return _homeDataArray;
}

//MARK:初始化已选应用数据源
- (NSMutableArray *)groupArray{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

//MARK:初始化CollectionViewLayout
- (UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (kScreenWidth - 40) / 4;
        //设置每个图片的大小
        self.layout.itemSize = CGSizeMake(width, width-15);
        //设置滚动方向的间距
        self.layout.minimumLineSpacing = 10;
        //设置上方的反方向
        self.layout.minimumInteritemSpacing = 0;
        //设置collectionView整体的上下左右之间的间距
        self.layout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10);
        //设置滚动方向
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

//MARK:初始化自定义segmentedControl
- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        NSMutableArray *sectionTitleArray = [NSMutableArray new];
        for (CategoryModel *model in _homeDataArray) {
            [sectionTitleArray addObject:model.title];
        }
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:sectionTitleArray];
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.frame = CGRectMake(0, 0, kScreenWidth, segmentControlH);
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.backgroundColor = kUIToneBackgroundColor;
        //选中状态颜色
        UIColor *selectedColor = [UIColor orangeColor];
        UIColor *unselectedColor = [UIColor whiteColor];
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
        self.navigationItem.titleView = _segmentedControl;
    }
    return _segmentedControl;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _sectionIndex = 0;
    
    //初始化数据源
    [self initData];
    //初始化segmentedControl
    [self segmentedControl];
    //初始化视图
    [self initUI];
}

#pragma mark - 主方法
/**
 初始化数据源
 */
- (void)initData{
    NSArray *titleArray = @[@"申报缴税", @"社保查询", @"涉税事项办理", @"综合查询", @"税务登记", @"税收优惠", @"办税导航", @"纳税咨询"];
    for (int i = 1; i < titleArray.count; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"%@", titleArray[i]];
        [self.homeDataArray addObject:model];
        
    }
    NSLog(@"%@", self.homeDataArray);
    for (int i = 0; i < 6; i++) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.title = [NSString stringWithFormat:@"menu%@", @(i)];
        [self.groupArray addObject:model];
    }
}

/**
 初始化视图
 */
- (void)initUI {
    self.appCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - navViewH - tabBarH) collectionViewLayout:self.layout];
    self.appCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.appCollectionView];
    self.appCollectionView.backgroundColor = [UIColor whiteColor];
    self.appCollectionView.delegate = self;
    self.appCollectionView.dataSource = self;
    
    [self.appCollectionView  registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryHomeShowAppCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [self.appCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableFooterView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
}

#pragma mark - 自定义SegmentControl
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    __weak typeof(self)weakSelf = self;
    [_homeDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (segmentedControl.selectedSegmentIndex == idx) {
            //跳转到指定的分区位置
            NSIndexPath* cellIndexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
            UICollectionViewLayoutAttributes *attr = [weakSelf.appCollectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:cellIndexPath];
            UIEdgeInsets insets = weakSelf.appCollectionView.scrollIndicatorInsets;
            
            CGRect rect = attr.frame;
            rect.size = weakSelf.appCollectionView.frame.size;
            rect.size.height -= insets.top + insets.bottom;
            CGFloat offset = (rect.origin.y + rect.size.height) - weakSelf.appCollectionView.contentSize.height;
            if (offset > 0.0) rect = CGRectOffset(rect, 0, -offset);
            [weakSelf.appCollectionView layoutIfNeeded];
            [weakSelf.appCollectionView scrollRectToVisible:rect animated:YES];
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到当前屏幕显示的所有的item，但是因为collectionView的重用机制，获取到的item的indexPath是乱序的
    NSArray* visibleCellIndex = self.appCollectionView.indexPathsForVisibleItems;
    // 对获取到乱序的item的indexPath进行排序，使其正常
    NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)obj1;
        NSIndexPath *path2 = (NSIndexPath *)obj2;
        return [path1 compare:path2];
    }];
    // 判断数组有没有值，防止数组越界，并且获取第一个indexPath
    if (sortedIndexPaths.count > 0) {
        NSIndexPath *index = [sortedIndexPaths firstObject];
        NSInteger section = index.section;
        //scrollView滑动时,同一个分区的section变化会出现N次,对应会N次调用setSelectedSegmentIndex方法
        //定义一个全局的_sectionIndex,当变化第一次出现变化时,调用setSelectedSegmentIndex
        if (_sectionIndex != section) {
            _sectionIndex = section;
            [_segmentedControl setSelectedSegmentIndex:index.section animated:YES];
        }
        return;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.homeDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryHomeShowAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setDataAry:self.homeDataArray groupAry:self.groupArray indexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%@个分区的第%@个cell", @(indexPath.section), @(indexPath.row));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        CategoryModel *model = _homeDataArray[indexPath.section];
        headerView.headerTitleLabel.text = model.title;
        headerView.intervalViews.hidden = YES;
//        if (indexPath.section == 0) {
//            headerView.intervalViews.hidden = NO;
//        }else{
//            headerView.intervalViews.hidden = YES;
//        }
        
        return headerView;
    } else {
        CollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section < _homeDataArray.count && section == (_homeDataArray.count - 1)) {
        return CGSizeMake(kScreenWidth, 350);
    }
    return CGSizeMake(kScreenWidth, 0);
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
