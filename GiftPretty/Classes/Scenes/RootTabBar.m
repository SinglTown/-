//
//  RootTabBar.m
//  PrettyGift
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "RootTabBar.h"
#import "VAGuideView.h"
#import "Common.h"
#import "UIImage+Ex.h"
@interface RootTabBar ()
{
   VAGuideView *_guideView;
   UIInterfaceOrientation _lockRotate;
   UIInterfaceOrientation _currInterfaceOrientation;
}
@property (nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation RootTabBar

- (void)viewDidLoad {
   [super viewDidLoad];
   
   // 设置title字体的颜色
   self.tabBar.tintColor = [UIColor blackColor];
   // 添加视图控制器
   //[self creatController];
   [self showGuide];
   
}

//调用引导页面方法
-(void)showGuide
{
   if ([VAGuideView shouldShowGuide]) {
      self.navigationController.navigationBar.hidden = YES;
      NSMutableArray *arrImage = [NSMutableArray array];
#pragma mark - 这里填你们到导航图  for循环控制张数   后面是图片的名字
      for (int i = 0; i < 4; i++) {
         UIImage *image = [UIImage imageWithFileName:[NSString stringWithFormat:@"%@-guide-%d-v", @"iPhone5", i] ofType:@"png"];
         [arrImage addObject:image];
      }
      _guideView = [VAGuideView guideViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) arrImages:arrImage space:30];
      //引导页背景图
      UIImageView *imageViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
#pragma mark - 这里是播放导航图时的背景图片  换成你们自己的即可
      imageViewBg.image = [UIImage imageNamed:@"iPhone_guide_bg"];
      //imageViewBg.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
      imageViewBg.contentMode = UIViewContentModeScaleAspectFill;
      imageViewBg.clipsToBounds = YES;
      [_guideView insertSubview:imageViewBg atIndex:0];
      // 适配引导视图的页面显示
      _guideView.imageContentMode = UIViewContentModeLeft | UIViewContentModeRight | UIViewContentModeTop | UIViewContentModeBottom;
      
      //最后一页进入应用按钮
      UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
      [btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
#pragma mark - 这是最后一页导航图上面按钮的控制，图片，文字，位置 点击方法（点击之后才创建首页视图,因为导航图消失时有动画效果，建议加个定时器，1秒之后才开始创建视图）
      [btnStart setBackgroundImage:[UIImage imageNamed:@"iPhone-anniubox-2"] forState:UIControlStateNormal];
      [btnStart setTitle:@"开始体验" forState:UIControlStateNormal];
      btnStart.frame = CGRectMake(0, self.view.frame.size.height - 90, 160, 40);
      btnStart.center = CGPointMake(self.view.frame.size.width/2,btnStart.center.y);
      [btnStart addTarget:self action:@selector(touchStartButton) forControlEvents:UIControlEventTouchUpInside];
      btnStart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
      [_guideView addButtonAtLastPage:btnStart];
      if (_guideView && arrImage.count>0) {
         _currInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
         _lockRotate = YES;
         [self.view addSubview:_guideView];
         double delayInSeconds = 0;
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [_guideView startAnimationWithDuration:3
                             animationComplecation:nil
                                        didDismiss:^{
                                           _lockRotate = NO;
                                        }];
         });
      }
   }
#pragma mark - 不是第一次启动，直接创建本页面视图
   else
   {
      _currInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
      _lockRotate = YES;
      [self creatController];
   }
}
-(void)touchStartButton
{
   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(creatController) userInfo:nil repeats:NO];
}

// 添加视图控制器的方法
- (void)creatController
{
   // 四个模块
   // 首页
   GiftIndexViewController *giftIndex = [[GiftIndexViewController alloc] init];
   UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:giftIndex];
   indexNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[self preventByDrawing:@"zhuye"] selectedImage:[self preventByDrawing:@"zhuye1"]];
   
   // 热门
   GiftHotViewController *giftHot = [[GiftHotViewController alloc] init];
   UINavigationController *hotNav = [[UINavigationController alloc] initWithRootViewController:giftHot];
   hotNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热门" image:[self preventByDrawing:@"remen"] selectedImage:[self preventByDrawing:@"remen1"]];
   
   // 分类
   GiftKindViewController *giftKind = [[GiftKindViewController alloc] init];
   UINavigationController *kindNav = [[UINavigationController alloc]initWithRootViewController:giftKind];
   kindNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[self preventByDrawing:@"fenlei"] selectedImage:[self preventByDrawing:@"fenlei1"]];
   
   // 我
   AboutViewController *user = [[AboutViewController alloc] init];
   UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:user];
   userNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"关于" image:[self preventByDrawing:@"wo"] selectedImage:[self preventByDrawing:@"wo1"]];
   
   // 同一导航栏颜色和取消半透明效果
   [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255/255.0 green:18/255.0 blue:120/255.0 alpha:1]];
   [[UINavigationBar appearance] setTranslucent: NO];
   
   // 将标签添加到tabViewController
   self.viewControllers = [NSArray arrayWithObjects:indexNav,hotNav,kindNav,userNav, nil];
}
// 防止图片被渲染
- (UIImage *)preventByDrawing:(NSString *)strImg
{
   UIImage *image = [UIImage imageNamed:strImg];
   image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   return image;
}

//// 懒加载
//- (NSMutableArray *)imageArray
//{
//   if (!_imageArray) {
//      self.imageArray = [NSMutableArray array];
//   }
//   return _imageArray;
//}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
