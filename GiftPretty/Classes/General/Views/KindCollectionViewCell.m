//
//  KindCollectionViewCell.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "KindCollectionViewCell.h"

@implementation KindCollectionViewCell
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
}

- (void)layoutSubviews
{
   [super layoutSubviews];
   
   self.myView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
   self.myView.layer.borderWidth = 0.3;
   self.myView.layer.borderColor = [UIColor yellowColor].CGColor;
   self.myView.layer.masksToBounds = YES;
   self.myView.layer.cornerRadius = 5;
   self.myView.backgroundColor = [UIColor colorWithRed:112/255.0 green:128/255.0 blue:105/255.0 alpha:0.1];
   
   self.iconImage.frame = CGRectMake(5, 10, self.myView.frame.size.width - 10, self.myView.frame.size.height - 20);
   self.iconImage.backgroundColor = [UIColor grayColor];
   self.iconImage.layer.masksToBounds = YES;
   self.iconImage.layer.cornerRadius = 5;
   // 设置图片的阴影
   //[self.iconImage.layer setShadowOffset:CGSizeMake(5, 5)];// 阴影的范围
   //[self.iconImage.layer setShadowRadius:4];// 阴影扩散的范围控制
   //[self.iconImage.layer setShadowOpacity:1];// 阴影透明度
   //[self.iconImage.layer setShadowColor:[UIColor brownColor].CGColor];// 阴影的颜色
   
}

@end
