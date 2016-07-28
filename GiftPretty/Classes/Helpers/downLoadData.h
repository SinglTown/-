//
//  downLoadData.h
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <Foundation/Foundation.h>

// 声明Block类型，有参数，没有返回值
typedef void (^Block) (NSData *data, BOOL isNetwork);

//// 设置代理
//@protocol sendDataDelegate <NSObject>
//
//- (void)sendDataBack:(NSData *)data;
//
//@end

@interface downLoadData : NSObject

//@property(nonatomic,assign)id<sendDataDelegate> myDelegate;

@property (nonatomic, copy) Block result;

// 声明下载的方法
- (void)downLoadDataWithUrlString:(NSString *)string;

#pragma mark - 判断是否有网络
//判断是否有网络 NO为无网络 YES为有网络
+ (BOOL)AbnormalNetworkConnection;

@end
