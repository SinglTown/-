
//
//  Created by 徐东macbook on 15/9/5.
//  Copyright (c) 2015年 徐东macbook. All rights reserved.
//


#import "VAGuideView.h"

#define kVAGuideView @"kVAGuideView"

@interface VAGuideView ()

- (void)tapGesture:(UIGestureRecognizer *)gesture;
- (void)onTouchValueChanaged:(UIPageControl *)pageControl;
- (void)onTouchStart;

@end

@implementation VAGuideView

- (void)setImageContentMode:(UIViewContentMode)imageContentMode
{
    for (UIImageView *imageView in _arrViews) {
        imageView.contentMode = imageContentMode;
    }
}

- (void)setBgColor:(UIColor *)bgColor
{
    
    _bgColor = nil;
    
    _bgColor = bgColor;
    
    for (UIImageView *imageView in _arrViews) {
        imageView.backgroundColor = _bgColor;
    }
}

- (void)dealloc
{
    _scrollView = nil;
   
    _pageControl = nil;
    
    _arrViews = nil;
    
    _button = nil;

    _bgColor = nil;
  
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _space = 20.0f;
        _arrViews = [NSMutableArray array];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame arrImages:(NSArray *)arrImages space:(CGFloat)space
{
    self = [self initWithFrame:frame];
    if (self) {
        _space = space;
        
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        CGRect rc = self.bounds;
        rc.size.width+=_space;
        _scrollView = [[UIScrollView alloc] initWithFrame:rc];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.panGestureRecognizer.cancelsTouchesInView = YES;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollView];
       
       // 分页的宽高
        rc.size.width = self.bounds.size.width;
        rc.size.height = 30;
        rc.origin.x = 0;
       // 所在的位置
        rc.origin.y = self.frame.size.height-rc.size.height-10;
        _pageControl = [[SMPageControl alloc] initWithFrame:rc];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [_pageControl setPageIndicatorImage:[UIImage imageNamed:@"dot-0-0"]];
        [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"dot-0-1"]];
        [self addSubview:_pageControl];
        
        rc = self.bounds;
        for (NSInteger index = 0; index < arrImages.count; index++) {
           
            rc.origin.x = index*(rc.size.width + _space);
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:rc];
            imageview.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            imageview.contentMode = UIViewContentModeScaleAspectFit;
            imageview.clipsToBounds = YES;
            //imageview.clipsToBounds = NO;
            imageview.image = [arrImages objectAtIndex:index];
            
            if (index == (arrImages.count - 1)) {
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
                [imageview addGestureRecognizer:tapGesture];
                imageview.userInteractionEnabled = YES;
                
                tapGesture = nil;
            }
            
            [_scrollView addSubview:imageview];
            [_arrViews addObject:imageview];
            imageview = nil;
        }
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*_arrViews.count, _scrollView.bounds.size.height);
        _pageControl.numberOfPages = arrImages.count;
        [_pageControl addTarget:self action:@selector(onTouchValueChanaged:) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPage = 0;
    }
    return self;
}

+ (id)guideViewWithFrame:(CGRect)frame arrImages:(NSArray *)arrImages space:(CGFloat)space
{
    if (![VAGuideView shouldShowGuide]) {
        return nil;
    }
    else {
        return [[VAGuideView alloc] initWithFrame:frame arrImages:arrImages space:space] ;
    }
}

+ (BOOL)shouldShowGuide
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    id ver = [ud objectForKey:kVAGuideView];
    if (ver) {
        if ([ver isKindOfClass:[NSString class]]) {
            // 新版使用 版本号
            if ([version compare:ver]==NSOrderedDescending) {
                // 倒序
                return YES;
            }
            else {
                return NO;
            }
        }
        else {
            // 说明是旧版，只有旧版才是 NSNumber 类型
            return YES;
        }
    }
    else {
        return YES;
    }
}

- (void)addButtonAtLastPage:(UIButton *)button 
{
   
    _button = button ;
    _rcButton = button.frame;
    UIImageView *imageView = [_arrViews lastObject];
    NSArray *arrGesture = [imageView gestureRecognizers];
    for (UIGestureRecognizer *gesture in arrGesture) {
        [gesture removeTarget:self action:@selector(tapGesture:)];
    }
    
    _rcButton.origin.x += (_arrViews.count - 1) * _scrollView.bounds.size.width;
    _paddingBottom = self.bounds.size.height - _rcButton.origin.y;
    _button.frame = _rcButton;
    [_button addTarget:self action:@selector(onTouchStart) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_button];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (_scrollView) {
        CGRect rc = self.bounds;
        rc.size.width += _space;
        _scrollView.frame = rc;
        rc = self.bounds;
        for (NSInteger index = 0; index < _arrViews.count; index++) {
            rc.origin.x = index * (rc.size.width + _space);
            UIView *bg = [_arrViews objectAtIndex:index];
            bg.frame = rc;
        }
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*_arrViews.count, _scrollView.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width*_pageControl.currentPage, 0);
        
        rc = _rcButton;
        rc.origin.y = self.bounds.size.height-_paddingBottom;
        rc.origin.x = _scrollView.bounds.size.width*(_arrViews.count-1)+floorf((self.bounds.size.width-rc.size.width)/2);
        _button.frame = rc;
    }
}

- (void)startAnimation:(AnimationComplecation)animationComplecation didDismiss:(DidDismiss)didDismiss;
{
    [self startAnimationWithDuration:4 animationComplecation:animationComplecation didDismiss:didDismiss];
}

- (void)startAnimationWithDuration:(NSTimeInterval)duration animationComplecation:(AnimationComplecation)animationComplecation didDismiss:(DidDismiss)didDismiss
{
    //    Block_release(_animationComplecation);
    //    Block_release(_didDismiss);
    //    _animationComplecation = Block_copy(animationComplecation);
    //    _didDismiss = Block_copy(didDismiss);
    
    _scrollView.userInteractionEnabled = NO;
    _pageControl.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration/2.0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*(_arrViews.count-1), 0)];
                         _scrollView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration/2.0
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              [_scrollView setContentOffset:CGPointMake(0, 0)];
                                              _scrollView.transform = CGAffineTransformIdentity;
                                          } completion:^(BOOL finished) {
                                              _scrollView.userInteractionEnabled = YES;
                                              _pageControl.userInteractionEnabled = YES;
                                              if (_animationComplecation) {
                                                  _animationComplecation();
                                              }
                                          }];
                     }];
}

- (void)dismiss:(DidDismiss)block
{
    if (block) {
        //        Block_release(_didDismiss);
        //        _didDismiss = Block_copy(block);
    }
    [UIView animateWithDuration:1
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(4, 4);
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1;
                         if (_didDismiss) {
                             _didDismiss();
                         }
                     }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / _scrollView.bounds.size.width;
}

- (void)tapGesture:(UIGestureRecognizer *)gesture
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:version forKey:kVAGuideView];
    [ud synchronize];
    
    [UIView animateWithDuration:1
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(4, 4);
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1;
                         if (_didDismiss) {
                             _didDismiss();
                         }
                     }];
}

- (void)onTouchValueChanaged:(UIPageControl *)pageControl
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width *_pageControl.currentPage, 0) animated:YES];
}

- (void)onTouchStart
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:version forKey:kVAGuideView];
    [ud synchronize];
    
    [UIView animateWithDuration:1
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(4, 4);
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1;
                         if (_didDismiss) {
                             _didDismiss();
                         }
                                              }];
}

@end

