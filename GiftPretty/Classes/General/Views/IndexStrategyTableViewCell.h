//
//  IndexStrategyTableViewCell.h
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexStrategyModal.h"
@interface IndexStrategyTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *indexStrategyImageV;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bgLabel;
@property (nonatomic, strong)IndexStrategyModal *indexStrategy;
@end
