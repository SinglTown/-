//
//  KindStrategyTableViewCell.h
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KindStrategyModal.h"
#import "UIImageView+WebCache.h"
@interface KindStrategyTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *kindStrategyImageV;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bgLabel;
@property (nonatomic, strong)KindStrategyModal *kindStrategyModal;
@end
