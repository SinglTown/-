//
//  GiftIndex.m
//  GiftTalk
//
//  Created by lanou3g on 15/9/28.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import "GiftIndex.h"

@implementation GiftIndex
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   // 如果id和key是相等的，直接把value的值给ID
   if ([key isEqualToString:@"id"]) {
      self.ID = value;
   }
}

@end
