//
//  CategoryHomeShowAppCell.m
//  ALinPayHome
//
//  Created by Qing Chang on 2017/6/13.
//  Copyright © 2017年 Qing Chang. All rights reserved.
//

#import "CategoryHomeShowAppCell.h"

@implementation CategoryHomeShowAppCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDataAry:(NSMutableArray *)dataAry groupAry:(NSMutableArray *)groupAry indexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = dataAry[indexPath.row];
    self.appTitle.text = model.title;
}


@end
