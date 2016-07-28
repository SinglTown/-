//
//  GiftIndexTVC.h
//  GiftTalk
//
//  Created by lanou3g on 15/9/28.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftIndex.h"
#import "UIImageView+WebCache.h"

@interface GiftIndexTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *giftImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bgLabel;
@property (nonatomic, strong)GiftIndex *giftIndex;
@end
