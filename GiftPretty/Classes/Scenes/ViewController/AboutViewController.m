//
//  AboutViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "AboutViewController.h"
#import "NavTitleHelper.h"
#import "SDImageCache.h"
#import "AboutUsViewController.h"
#import "DisclaimerViewController.h"
@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   UIAlertController *alert;
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self createTitleView];
   UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) style:UITableViewStylePlain];
   tab.delegate = self;
   tab.dataSource = self;
   [self.view addSubview:tab];
//   UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutbg.jpeg"]];
//   imageV.frame = CGRectMake(10, tab.frame.size.height + 5, self.view.frame.size.width - 20, 70);
//   [self.view addSubview:imageV];
}

- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"关于"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}

// 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
   }
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   cell.highlighted = NO;
   if (indexPath.row == 0) {
      cell.textLabel.text = @"清除缓存";
      
   } else if (indexPath.row == 1) {
      cell.textLabel.text = @"关于软件";
   }  else if (indexPath.row == 2){
      cell.textLabel.text = @"免责声明";
   } else {
      cell.textLabel.text = @"其它";
   }
   
   // cell.highlighted = YES;
   return cell;
}



// 点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.row == 0) {
      NSString *string = [NSString stringWithFormat:@"清除缓存%.2lfM完成！",[[SDImageCache sharedImageCache] getSize] *0.1 / 1024.0 / 1024.0];
      [[SDImageCache sharedImageCache] clearDisk];
      alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
      [self presentViewController:alert animated:YES completion:nil];
      [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissAlert) userInfo:nil repeats:YES];
      
   } else if (indexPath.row == 1) {
      AboutUsViewController *aboutUs = [[AboutUsViewController alloc] init];
      [self.navigationController pushViewController:aboutUs animated:YES];
   } else if (indexPath.row == 2) {
      DisclaimerViewController *disclaimer = [[DisclaimerViewController alloc] init];
      [self.navigationController pushViewController:disclaimer animated:YES];
   }
   
   else {
      alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂时无此内容！" preferredStyle:UIAlertControllerStyleAlert];
      //[alert show];
      [self presentViewController:alert animated:YES completion:nil];
      [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissAlert) userInfo:nil repeats:YES];
   }
   
}
//干掉alertView
- (void)dismissAlert
{
   [alert dismissViewControllerAnimated:YES completion:^{
      
   }];
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
