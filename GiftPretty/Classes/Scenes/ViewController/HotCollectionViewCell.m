//
//  HotCollectionViewCell.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "HotCollectionViewCell.h"

@implementation HotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      [self createMyView];
   }
   return self;
}

- (void)createMyView
{
   self.myView = [[UIView alloc] init];
   [self.contentView addSubview: self.myView];
   
   self.iconImage = [[UIImageView alloc] init];
   [self.myView addSubview: self.iconImage];
   
   self.nameStr = [[UILabel alloc] init];
   [self.myView addSubview: self.nameStr];
   
   self.priceLabel = [[UILabel alloc] init];
   [self.myView addSubview: self.priceLabel];
}

- (void)layoutSubviews
{
   [super layoutSubviews];
   self.myView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
   self.myView.layer.borderWidth = 0.3;
   self.myView.layer.borderColor = [UIColor lightGrayColor].CGColor;
   
   self.iconImage.frame = CGRectMake(5, 5, self.myView.frame.size.width - 10, self.myView.frame.size.height - 50);
   self.iconImage.backgroundColor = [UIColor grayColor];
   
   self.nameStr.frame = CGRectMake(5, self.iconImage.frame.size.height + 5, self.iconImage.frame.size.width, 20);
   self.nameStr.font = [UIFont systemFontOfSize:12];
   self.nameStr.textColor = [UIColor grayColor];
   self.nameStr.textAlignment = NSTextAlignmentCenter;
   
   self.priceLabel.frame = CGRectMake(5,self.myView.frame.size.height - 25, self.nameStr.frame.size.width, 25);
   self.priceLabel.font = [UIFont systemFontOfSize:12];
   self.priceLabel.textColor = [UIColor redColor];
   self.priceLabel.textAlignment = NSTextAlignmentCenter;
   
   
}


@end
