//
//  BeautifulThingsTableViewCell.h
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeautifulThingsModal.h"
@interface BeautifulThingsTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *beautifulThingsImageV;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bgLabel;
@property (nonatomic, strong)BeautifulThingsModal *beautifulThingsModal;
@end
