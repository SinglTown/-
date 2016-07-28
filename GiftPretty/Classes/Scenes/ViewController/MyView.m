//
//  MyView.m
//  GiftPretty
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 徐东. All rights reserved.
//

#import "MyView.h"

@implementation MyView

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}

@end
