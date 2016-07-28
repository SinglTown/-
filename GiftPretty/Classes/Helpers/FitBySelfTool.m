//
//  FitBySelfTool.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "FitBySelfTool.h"

@implementation FitBySelfTool

- (CGFloat)getLabelHeight:(CGFloat)howBig with:(CGFloat)width content:(NSString *)content
{
   // 死算法，记住就行
   // 高度尽量给大值
   CGSize size = CGSizeMake(width, 10000);
   NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:howBig] forKey:NSFontAttributeName];
   CGRect rc = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
   return rc.size.height;
}
@end
