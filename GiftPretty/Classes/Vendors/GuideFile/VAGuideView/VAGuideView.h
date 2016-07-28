
//
//  Created by 徐东macbook on 15/9/5.
//  Copyright (c) 2015年 徐东macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMPageControl.h"

typedef void (^AnimationComplecation) (void);
typedef void (^DidDismiss) (void);

@interface VAGuideView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
   
    // 分页控制
    SMPageControl *_pageControl;
    
    NSMutableArray *_arrViews;
    
    AnimationComplecation _animationComplecation;
    DidDismiss _didDismiss;
    
    CGRect _rcButton;
    UIButton *_button;
    CGFloat _paddingBottom;
    
    
    NSString * flag;
}

// ipad 或 iphone 向导图的数目不等， 底部点标识显示与隐藏的区间不同
@property (nonatomic, assign) CGFloat markSpace;

// item space
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) UIViewContentMode imageContentMode;
@property (nonatomic, retain) UIColor *bgColor;

- (id)initWithFrame:(CGRect)frame arrImages:(NSArray *)arrImages space:(CGFloat)space;
+ (id)guideViewWithFrame:(CGRect)frame arrImages:(NSArray *)arrImages space:(CGFloat)space;
+ (BOOL)shouldShowGuide;

- (void)addButtonAtLastPage:(UIButton *)button;

- (void)startAnimation:(AnimationComplecation)animationComplecation
            didDismiss:(DidDismiss)didDismiss;
- (void)startAnimationWithDuration:(NSTimeInterval)duration
             animationComplecation:(AnimationComplecation)animationComplecation
                        didDismiss:(DidDismiss)didDismiss;

- (void)dismiss:(DidDismiss)block;

@end
