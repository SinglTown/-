//
//  NavTitleHelper.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "NavTitleHelper.h"

@implementation NavTitleHelper

// 单例方法
+ (instancetype)SharedNavTitleHelper
{
   static NavTitleHelper *helper = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      helper = [[NavTitleHelper alloc] init];
   });
   return helper;
}
// 设置导航控制器title的样式
- (UILabel *)createNavTitleView:(NSString *)str
{
   UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 150, 20)];
   lable.text = str;
   lable.textColor = [UIColor whiteColor];
   lable.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20.0];
   
   lable.textAlignment = NSTextAlignmentCenter;
   return lable;
}

@end
