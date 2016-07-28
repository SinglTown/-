//
//  IndexBanner.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexBanner.h"
#import "IndexBanners.h"
#import "UIImageView+WebCache.h"
#import "downLoadData.h"
#import "IndexGuideMap.h"
@interface IndexBanner ()<UIScrollViewDelegate>
{
   UIScrollView *banner;
   NSMutableArray *slideImages;
   UIPageControl *pageControl;
   NSInteger pagenumber;
}
@property (nonatomic, strong)NSMutableArray *bannersArray;
@end

@implementation IndexBanner

//重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      //调用视图的方法
      [self creatMyView];
   }
   return self;
}

// 创建视图的方法
- (void)creatMyView
{
   slideImages = [NSMutableArray array];
   // 定时器 循环
   //定时器 循环
   [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePicture) userInfo:nil repeats:YES];
   //计数，控制图片滚动
   pagenumber = 0;
   
   banner = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
   //banner.backgroundColor = [UIColor redColor];
   // 分页显示
   banner.pagingEnabled = YES;
   banner.bounces = YES;
   // 取消滚动条
   banner.showsHorizontalScrollIndicator = YES;
   banner.showsVerticalScrollIndicator = NO;
   banner.userInteractionEnabled = YES;
   // 指定代理人
   banner.delegate = self;
   [self addSubview:banner];
   
   IndexGuideMap *map = [[IndexGuideMap alloc] initWithFrame:CGRectMake(0, banner.frame.size.height + 5, self.frame.size.width, 70)];
   [self addSubview:map];
   
   [self downLoadThisPage];
   
}

// 实现代理方法
- (void)downLoadThisPage
{
   // 解析
   // 创建downLoad对象
   downLoadData *downLoad = [[downLoadData alloc] init];
   // 设置代理
   [downLoad downLoadDataWithUrlString:KGiftIndexBannersURL];
   downLoad.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         NSArray *array = [resultDic objectForKey:@"banners"];
         for (NSDictionary *dic in array) {
            IndexBanners *index = [[IndexBanners alloc] init];
            [index setValuesForKeysWithDictionary:dic];
            [self.bannersArray addObject:index];
            // 把图片装进数组
            NSString *str = index.image_url;
            // 将图片添加到数组
            [slideImages addObject:str];
         }
         // 初始化pageControl
         pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, banner.frame.size.height - 20, 40, 20)];
         pageControl.numberOfPages = [slideImages count];
         pageControl.pageIndicatorTintColor = [UIColor whiteColor];
         pageControl.currentPageIndicatorTintColor = [UIColor magentaColor];
         [pageControl addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventValueChanged];
         [self addSubview:pageControl];
         [self imageHelper];
         [self imageLoop];
      } else {
         
      }
   };
   
}


//ScrollView循环滚动
- (void)changePicture
{
   if (pagenumber == [_bannersArray count]) {
      banner.contentOffset = CGPointMake(0, 0);
      pagenumber = 0;
   }
   [banner setContentOffset:CGPointMake(self.frame.size.width + self.frame.size.width * pagenumber, 0) animated:YES];
   pagenumber ++;
}

//pageControl点击方法
- (void)clickMe:(UIPageControl *)page
{
   NSInteger number = page.currentPage;
   [banner setContentOffset:CGPointMake(self.frame.size.width *number, 0) animated:YES];
}

//UIScrollView实现代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   int currentPage = (int)banner.contentOffset.x/self.frame.size.width;
   currentPage -- ; //默认从第二页开始
   pageControl.currentPage = currentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   //NSLog(@"%ld",slideImages.count);
   int currentPage = (int)banner.contentOffset.x/self.frame.size.width;
   //NSLog(@"currentPage_==%d",currentPage);
   if (currentPage == 0)
   {
      
      [banner scrollRectToVisible:CGRectMake(self.frame.size.width * [slideImages count],0,self.frame.size.width,120) animated:NO]; // 序号0 最后1页
   }
   else if (currentPage == ([slideImages count]+1))
   {
      [banner scrollRectToVisible:CGRectMake(self.frame.size.width,0,self.frame.size.width,120) animated:NO]; // 最后+1,循环第1页
   }
   
}

// 创建图片
- (void)imageHelper
{
   for (int i = 0; i < [slideImages count]; i ++) {
      UIImageView *imageV = [[UIImageView alloc] init];
      [imageV sd_setImageWithURL:[NSURL URLWithString:[slideImages objectAtIndex:i]]placeholderImage:[UIImage imageNamed:@"zanwei.jpg"]];
      imageV.frame = CGRectMake(self.frame.size.width * (i + 1), 0, self.frame.size.width, 120);
      [banner addSubview:imageV];
   }
}

// 处理循环图片的方法
- (void)imageLoop
{
   // 取数组最后一张图片 放在第0页
   UIImageView *imageView = [[UIImageView alloc] init];
   [imageView sd_setImageWithURL:[NSURL URLWithString:[slideImages objectAtIndex:[slideImages count] - 1]]];
   // 添加最后一页在首页位置 循环
   imageView.frame = CGRectMake(0, 0, self.frame.size.width, 120);
   [banner addSubview:imageView];
   //取数组第一张图片 放在最后一页
   imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
   imageView.frame = CGRectMake(self.frame.size.width * ([slideImages count] + 1 ), 0, self.frame.size.width, 120);
   [banner addSubview:imageView];
   //首先设置可滚动区域  3-[0-1-2-3]-0
   banner.contentSize = CGSizeMake(self.frame.size.width * ([slideImages count] + 2), 120);
   banner.contentOffset = CGPointMake(0, 0);
   //默认从序号1位置放第1页 序号0位置放第5页
   [banner scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, 120) animated:YES];
}


// 懒加载
- (NSMutableArray *)bannersArray
{
   if (!_bannersArray) {
      self.bannersArray = [NSMutableArray array];
   }
   return _bannersArray;
}




@end
