//
//  HotDetailsViewController.h
//  GiftPretty
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientProgressView.h"
@interface HotDetailsViewController : UIViewController
{
   GradientProgressView *progressView;
}
// 属性传值
@property(nonatomic, assign)NSInteger ID;
@end
