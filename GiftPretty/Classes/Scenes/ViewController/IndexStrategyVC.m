//
//  IndexStrategyVC.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexStrategyVC.h"
#import "downLoadData.h"
#import "IndexStrategyModal.h"
#import "NavTitleHelper.h"
#import "IndexStrategyTableViewCell.h"
#import "KindStrategyViewController.h"
@interface IndexStrategyVC ()<UITableViewDataSource,UITableViewDelegate>
{
   UITableView *tab;
}
@property (nonatomic, strong) NSMutableArray *indexStrategyArray;
@end

@implementation IndexStrategyVC

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   [self createTitleView];
   [self downLoadThePage];
   // Do any additional setup after loading the view.
}
// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"全部专题"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}
// 点击导航栏左侧按钮的方法
- (void)touchToScan
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
   [down downLoadDataWithUrlString:@"http://api.liwushuo.com/v1/collections?offset=0&limit=20"];
   down.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         NSArray *array = [resultDic objectForKey:@"collections"];
         for (NSDictionary *dic in array) {
            IndexStrategyModal *indexStrategy = [[IndexStrategyModal alloc] init];
            [indexStrategy setValuesForKeysWithDictionary:dic];
            [self.indexStrategyArray addObject:indexStrategy];
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

// UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 180;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _indexStrategyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"cell";
   IndexStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) {
      cell = [[IndexStrategyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
   }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   IndexStrategyModal *indexStrategyModal = [_indexStrategyArray objectAtIndex:indexPath.row];
   cell.indexStrategy = indexStrategyModal;
   return cell;
}
// 点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   KindStrategyViewController *kindStrategy = [[KindStrategyViewController alloc] init];
   IndexStrategyModal *indexStrategyModal = [_indexStrategyArray objectAtIndex:indexPath.row];
   kindStrategy.ID = indexStrategyModal.id;
   kindStrategy.titleText = indexStrategyModal.title;
   [self.navigationController pushViewController:kindStrategy animated:YES];
}

// 懒加载
- (NSMutableArray *)indexStrategyArray
{
   if (!_indexStrategyArray) {
      _indexStrategyArray = [NSMutableArray array];
   }
   return _indexStrategyArray;
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
