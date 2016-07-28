//
//  GiftIndexTVC.m
//  GiftTalk
//
//  Created by lanou3g on 15/9/28.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import "GiftIndexTVC.h"
#import <UIKit/UIKit.h>


@implementation GiftIndexTVC

- (void)setGiftIndex:(GiftIndex *)giftIndex
{
   self.bgLabel.layer.masksToBounds = YES;
   self.bgLabel.layer.cornerRadius = 5;
   [self.giftImageV sd_setImageWithURL:[NSURL URLWithString:giftIndex.cover_image_url] placeholderImage:[UIImage imageNamed:@"cacheImage3"]];
   self.titleLabel.text = giftIndex.title;
   // 自适应 必须按照下边的顺序
   self.titleLabel.font = [UIFont systemFontOfSize:16];
   self.titleLabel.numberOfLines = 10000;
   [self.titleLabel sizeToFit];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
