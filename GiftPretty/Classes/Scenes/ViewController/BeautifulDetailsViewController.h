//
//  BeautifulDetailsViewController.h
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientProgressView.h"
@interface BeautifulDetailsViewController : UIViewController
{
   GradientProgressView *progressView;
}
@property (nonatomic, strong) NSString *webURL;
@end
