//
//  KindStrategyViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "KindStrategyViewController.h"
#import "NavTitleHelper.h"
#import "downLoadData.h"
#import "KindStrategyModal.h"
#import "KindStrategyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FitBySelfTool.h"
#import "KindStrategyDetailsVC.h"
@interface KindStrategyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   UITableView *tab;
   NSMutableArray *imageArray;
}
@property(nonatomic,strong)NSMutableArray *kindStrategyArray;
@end

@implementation KindStrategyViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToBack)];
   [self createTitleView];
   [self downLoadThePage];
}
// 导航栏标题
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:self.titleText];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}
// 点击导航栏左侧按钮的方法
- (void)touchToBack
{
   [self.navigationController popViewControllerAnimated:YES];
}
// 视图将要出现时隐藏tabBar
- (void)viewWillAppear:(BOOL)animated

{
   [super viewWillAppear:animated];
   self.tabBarController.tabBar.hidden=YES;
}

// 视图将要消失时显示tabBar
- (void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
   self.tabBarController.tabBar.hidden=NO;
}

// 解析
- (void)downLoadThePage
{
   downLoadData *down = [[downLoadData alloc] init];
   NSString *str = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/collections/%@/posts?limit=20",self.ID];
   [down downLoadDataWithUrlString:str];
   down.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         imageArray = [NSMutableArray array];
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         NSArray *array = [resultDic objectForKey:@"posts"];
         for (NSDictionary *dic in array) {
            KindStrategyModal *kindStrategy = [[KindStrategyModal alloc] init];
            [kindStrategy setValuesForKeysWithDictionary:dic];
            [self.kindStrategyArray addObject:kindStrategy];
            [imageArray addObject:kindStrategy.cover_image_url];
         }
         tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
         tab.delegate = self;
         tab.dataSource = self;
         [self.view addSubview:tab];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
   };
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FitBySelfTool *tool = [[FitBySelfTool alloc] init];
   KindStrategyModal *kindStrategy = [_kindStrategyArray objectAtIndex: indexPath.row];
   CGFloat f = [tool getLabelHeight:18 with:self.view.frame.size.width - 20 content:kindStrategy.title];
   return 180 - 60 + f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *indentifier = @"cell";
   KindStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
   if (cell == nil) {
      cell = [[KindStrategyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
   }
   KindStrategyModal *kindStrategy = [_kindStrategyArray objectAtIndex:indexPath.row];
   [cell.kindStrategyImageV sd_setImageWithURL:[NSURL URLWithString:kindStrategy.cover_image_url] placeholderImage:[UIImage imageNamed:@"cacheImage3"]];
   cell.kindStrategyModal = kindStrategy;
   return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.kindStrategyArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   KindStrategyDetailsVC *kindDetails = [[KindStrategyDetailsVC alloc] init];
   KindStrategyModal *kindStrategy = [_kindStrategyArray objectAtIndex:indexPath.row];
   kindDetails.webURL = kindStrategy.url;
   [self.navigationController pushViewController:kindDetails animated:YES];
}

// 懒加载
- (NSMutableArray *)kindStrategyArray
{
   if (!_kindStrategyArray) {
      self.kindStrategyArray = [NSMutableArray array];
   }
   return _kindStrategyArray;
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
