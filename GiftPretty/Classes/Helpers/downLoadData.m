//
//  downLoadData.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "downLoadData.h"
#import "Reachability.h"
@implementation downLoadData

- (void)downLoadDataWithUrlString:(NSString *)string
{
//   NSURL *url = [NSURL URLWithString:string];
//   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//   request.HTTPMethod = @"GET";
//   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//      // 数据下载好了 利用代理进行回转
//      [self.myDelegate sendDataBack: data];
//   }];
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
   [request setHTTPMethod:@"GET"];
   
   
   NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
      // 回主线程
      dispatch_async(dispatch_get_main_queue(), ^{
         
         if ([downLoadData AbnormalNetworkConnection] == NO) {
            self.result(nil,NO);
            return;
         }
         self.result(data,YES);
         
      });
      
   }];
    [task resume];
}

#pragma mark - 判断是否有网络
+ (BOOL)AbnormalNetworkConnection{
   Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//   
//   if ([reach currentReachabilityStatus] != ReachableViaWiFi && [reach currentReachabilityStatus] != ReachableViaWWAN) {
//      return NO;
//   }else{
//      return YES;
//   }
   BOOL AbnormalNetworkConnection;
   switch([reach currentReachabilityStatus]) {
      case NotReachable:
         AbnormalNetworkConnection = FALSE;
         break;
      case ReachableViaWWAN:
         AbnormalNetworkConnection = TRUE;
         break;
      case ReachableViaWiFi:
         AbnormalNetworkConnection = TRUE;
         break;
   }
   return  AbnormalNetworkConnection;
}

@end
