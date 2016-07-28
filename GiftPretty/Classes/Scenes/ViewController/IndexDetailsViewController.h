//
//  IndexDetailsViewController.h
//  GiftPretty
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientProgressView.h"
@interface IndexDetailsViewController : UIViewController
{
   GradientProgressView *progressView;
}
// 属性传值
@property(nonatomic, strong)NSNumber *ID;
@end
