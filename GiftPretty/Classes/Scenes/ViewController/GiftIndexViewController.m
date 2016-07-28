
//  GiftIndexViewController.m
//  PrettyGift
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.

#import "GiftIndexViewController.h"
#import "NavTitleHelper.h"
#import "downLoadData.h"
#import "GiftIndex.h"
#import "GiftIndexTVC.h"
#import "FitBySelfTool.h"
#import "IndexBanner.h"
#import "IndexDetailsViewController.h"
#import "IndexGuideMap.h"
#import "BeautifulLittleThingsVC.h"
#import "IndexStrategyVC.h"

#import "LittleHotsaleVC.h"
#import "LittleGiftstoryVC.h"
#import "IndexSearchViewController.h"

@interface GiftIndexViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   // 菊花小控件
   UIActivityIndicatorView *activity;
   // 表视图
   UITableView *tab;
   IndexBanner *indexBannaer;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation GiftIndexViewController


- (void)viewDidLoad {
   [super viewDidLoad];
   [self createTitleView];
   UIImage *image = [UIImage imageNamed:@"sousuo1"];
   image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//   UIImage *image1 = [UIImage imageNamed:@"saosao"];
//   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(touchToSearch)];
//   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   
   // 小菊花加载
   [self activityIndicatorViewLoad];
   [self downLoadThePage];
   
   
}
// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"礼物有话"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}

// 设置菊花转转转
- (void)activityIndicatorViewLoad
{
   // 初始化小菊花
   activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   // 颜色
   activity.color = [UIColor blueColor];
   activity.center = self.view.center;
   [self.view addSubview: activity];
   // 小菊花转起来
   [activity startAnimating];
   
}

// 点击导航栏右侧按钮的方法
- (void)touchToSearch
{
   IndexSearchViewController *search = [[IndexSearchViewController alloc] init];
   [self.navigationController pushViewController:search animated:YES];
}

// 点击导航栏左侧按钮的方法
- (void)touchToScan
{
   
}
// 实现代理的方法
- (void)downLoadThePage
{
  // 解析
   // 创建downLoad对象
   downLoadData *downLoad = [[downLoadData alloc] init];
   // 设置代理
   [downLoad downLoadDataWithUrlString:kGiftIndexListURL];
   downLoad.result = ^(NSData *data,BOOL isNetWorking) {
      if (isNetWorking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         NSArray *array = [resultDic objectForKey:@"items"];
         for (NSDictionary *dic in array) {
            GiftIndex *index = [[GiftIndex alloc] init];
            [index setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:index];
         }
         // 停止小菊花
         [activity stopAnimating];
         // 调用创建tableView方法
         [self createTableView];
         [tab reloadData];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
   };
   
}

// 创建tableView
- (void)createTableView
{
   tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
   tab.delegate = self;
   tab.dataSource = self;
   tab.separatorStyle = UITableViewCellSeparatorStyleNone;
   
   indexBannaer = [[IndexBanner alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
   tab.tableHeaderView = indexBannaer;
   
//   UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//   touchButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
//   //touchButton.backgroundColor = [UIColor blackColor];
//   [touchButton addTarget:self action:@selector(touchBannerButton) forControlEvents:UIControlEventTouchUpInside];
//   [indexBannaer addSubview:touchButton];
   
   
   UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
   button1.frame = CGRectMake(self.view.frame.size.width / 4 / 2 - 20, indexBannaer.frame.size.height - 70, 40, 40);
   //button1.backgroundColor = [UIColor blackColor];
   button1.showsTouchWhenHighlighted = YES;
   [indexBannaer addSubview:button1];
   
   UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
   button2.frame = CGRectMake(self.view.frame.size.width / 4 + self.view.frame.size.width / 4 / 2 - 20, indexBannaer.frame.size.height - 70, 40, 40);
   button2.showsTouchWhenHighlighted = YES;
   //button2.backgroundColor = [UIColor blackColor];
   [indexBannaer addSubview:button2];
   
   UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
   button3.frame = CGRectMake(self.view.frame.size.width / 4 * 2 + self.view.frame.size.width / 4 / 2 - 20, indexBannaer.frame.size.height - 70, 40, 40);
   button3.showsTouchWhenHighlighted = YES;
   //button3.backgroundColor = [UIColor blackColor];
   [indexBannaer addSubview:button3];
   
   UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
   button4.frame = CGRectMake(self.view.frame.size.width / 4 * 3 + self.view.frame.size.width / 4 / 2 - 20, indexBannaer.frame.size.height - 70, 40, 40);
   button4.showsTouchWhenHighlighted = YES;
   //button4.backgroundColor = [UIColor blackColor];
   [indexBannaer addSubview:button4];
   
   [button1 addTarget:self action:@selector(touchButton1) forControlEvents:UIControlEventTouchUpInside];
   [button2 addTarget:self action:@selector(touchButton2) forControlEvents:UIControlEventTouchUpInside];
   [button3 addTarget:self action:@selector(touchButton3) forControlEvents:UIControlEventTouchUpInside];
   [button4 addTarget:self action:@selector(touchButton4) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:tab];
   
}

- (void)touchBannerButton
{
   IndexStrategyVC *indexStrategy = [[IndexStrategyVC alloc] init];
   [self.navigationController pushViewController:indexStrategy animated:YES];
}

- (void)touchButton1
{
   BeautifulLittleThingsVC *beautifulThings = [[BeautifulLittleThingsVC alloc] init];
   [self.navigationController pushViewController:beautifulThings animated:YES];
   
}
- (void)touchButton2
{
   IndexStrategyVC *indexStrategy = [[IndexStrategyVC alloc] init];
   [self.navigationController pushViewController:indexStrategy animated:YES];
}

- (void)touchButton3
{
   LittleHotsaleVC *indexHot = [[LittleHotsaleVC alloc] init];
   [self.navigationController pushViewController:indexHot animated:YES];
}
- (void)touchButton4
{
   LittleGiftstoryVC *indexGiftStory = [[LittleGiftstoryVC alloc] init];
   [self.navigationController pushViewController:indexGiftStory animated:YES];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate Methods
// cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _dataArray.count;
}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FitBySelfTool *tool = [[FitBySelfTool alloc] init];
   GiftIndex *index = [_dataArray objectAtIndex: indexPath.row];
   CGFloat f = [tool getLabelHeight:16 with:self.view.frame.size.width - 20 content:index.title];
   return 180 - 60 + f;
}

// 点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   IndexDetailsViewController *indexDetails = [[IndexDetailsViewController alloc]init];
   GiftIndex *index = _dataArray[indexPath.row];
   
   indexDetails.ID = index.ID;
   [self.navigationController pushViewController:indexDetails animated:YES];
}

// 返回cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *indentifier = @"cell";
   GiftIndexTVC *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
   if (cell == nil) {
      cell = [[[NSBundle mainBundle] loadNibNamed:@"GiftIndexTVC" owner:nil options:nil] lastObject];
   }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   GiftIndex *index = [_dataArray objectAtIndex:indexPath.row];
   cell.giftIndex = index;
   return cell;
}

// 懒加载
- (NSMutableArray *)dataArray
{
   if (!_dataArray) {
      self.dataArray = [NSMutableArray array];
   }
   return _dataArray;
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
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
