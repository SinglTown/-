//
//  AboutUsViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "AboutUsViewController.h"
#import "NavTitleHelper.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToBack)];
   [self createTitleView];
   [self createAboutUsView];
}
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"关于软件"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}
// 页面美化
- (void)createAboutUsView
{
   UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
   imageV.frame = CGRectMake(self.view.frame.size.width / 2 - 60, 30, 120, 120);
   [self.view addSubview:imageV];
   imageV.layer.masksToBounds = YES;
   imageV.layer.cornerRadius = 60;
   imageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
   imageV.layer.borderWidth = 0.4;
   
   // 软件介绍
   UILabel *labelIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, self.view.frame.size.width - 40, 30)];
   labelIntroduce.text = @"软件介绍:";
   
   [self.view addSubview:labelIntroduce];
   UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, self.view.frame.size.width - 40, 130)];
   labelContent.font = [UIFont systemFontOfSize:16];
   labelContent.numberOfLines = 0;
   NSString *stringLabel = @"        本应用致力于礼尚往来，送礼选礼物，礼物的含义，方便用户浏览查看各种新奇礼物，挑选最有意义，更有内涵的礼物，送给他、她，欢迎广大用户下载体验。";
   // 行间距
   NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:stringLabel];
   NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
   [paragraphStyle1 setLineSpacing:8];
   [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [stringLabel length])];
   [labelContent setAttributedText:attributedString1];
   [labelContent sizeToFit];
   
   [self.view addSubview:labelContent];
   
   UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 350, 200, 30)];
   lable1.text = @"软件版本：礼物有话1.0";
   [self.view addSubview:lable1];
   lable1.textColor = [UIColor grayColor];
   UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 390, self.view.frame.size.width - 40, 30)];
   lable2.text = @"开发者：徐东";
   [self.view addSubview:lable2];
   lable2.textColor = [UIColor grayColor];
   
   UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 430, self.view.frame.size.width - 40, 30)];
   label3.text = @"开发时间：2015年10月";
   [self.view addSubview:label3];
   label3.textColor = [UIColor grayColor];
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
