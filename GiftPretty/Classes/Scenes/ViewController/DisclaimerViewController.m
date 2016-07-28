//
//  DisclaimerViewController.m
//  TravelGuide
//
//  Created by lanou3g on 15/10/16.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "NavTitleHelper.h"
@interface DisclaimerViewController ()

@end

@implementation DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   [self createTitleView];
   //button.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToBack)];
   UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 30)];
   label.text = @"免责声明：";
   label.font = [UIFont systemFontOfSize:18 weight:10];
   [self.view addSubview:label];
   
   UILabel *labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width - 40, 100)];
   labelMessage.numberOfLines = 10;
   NSString *stringLabel = @"      本应用素材均来自第三方或网页信息，只为用户选择礼物提供参考，并不做任何盈利行为，因此不承担由于网页内容的合法性所引起的一切争议和法律责任，不承担用户人身财产安全。";
   
   // 行间距
   NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:stringLabel];
   NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
   [paragraphStyle1 setLineSpacing:8];
   [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [stringLabel length])];
   [labelMessage setAttributedText:attributedString1];
   [labelMessage sizeToFit];
   
   [self.view addSubview:labelMessage];
   
}
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"免责声明"];
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
