//
//  CategoryHomeShowAppCell.h
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryHomeShowAppCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *appTitle;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) CategoryModel *model;

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath;

@end
