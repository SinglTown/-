//
//  FitBySelfTool.h
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <Foundation/Foundation.h>

// 一般牵涉到算法的，最好都重新写一个类Tool

@interface FitBySelfTool : NSObject
// 声明一个方法计算label的高度
- (CGFloat)getLabelHeight:(CGFloat)howBig with:(CGFloat)width content:(NSString *)content;


@end
