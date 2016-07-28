//
//  NavTitleHelper.h
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavTitleHelper : NSObject

// 声明单例方法
+ (instancetype)SharedNavTitleHelper;

// 设置导航控制器title的样式
- (UILabel *)createNavTitleView:(NSString *)str;

@end
