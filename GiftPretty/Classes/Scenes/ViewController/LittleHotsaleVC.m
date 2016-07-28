//
//  LittleHotsaleVC.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "LittleHotsaleVC.h"
#import "NavTitleHelper.h"
#import "GiftHotModal.h"
#import "downLoadData.h"
#import "HotCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HotDetailsViewController.h"
@interface LittleHotsaleVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
   // 记录item的图片数组
   NSMutableArray *itemArray;
   NSMutableArray *arcItemArray;
}
@property (nonatomic, strong)NSMutableArray *hotArray;
@property (nonatomic, strong)NSMutableArray *ArcArray;
@end

@implementation LittleHotsaleVC

- (void)viewDidLoad {
   [super viewDidLoad];
   itemArray = [NSMutableArray array];
   arcItemArray = [NSMutableArray array];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   [self createTitleView];
   [self downLoadThisPage];
   
}
// 解析
- (void)downLoadThisPage
{
   downLoadData *down = [[downLoadData alloc] init];
   [down downLoadDataWithUrlString:kGiftHotURL2];
   down.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *AllDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *DataDic = [AllDataDic objectForKey:@"data"];
         NSArray *array = [DataDic objectForKey:@"items"];
         
         for (NSDictionary *dic in array) {
            GiftHotModal *hot = [[GiftHotModal alloc] init];
            [hot setValuesForKeysWithDictionary:dic];
            [self.hotArray addObject:hot];
            NSString *str = [hot.data valueForKey:@"cover_image_url"];
            [itemArray addObject:str];
         }
         [self createCollectionView];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
      
   };
   
}
- (void)createCollectionView
{
   // 创建布局类
   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
   // 最小行间距
   layout.minimumLineSpacing = 10;
   // 最小列间距
   layout.minimumInteritemSpacing = 10;
   // 设置距离屏幕上左下右边距
   layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
   // 设置滚动方向（垂直）
   layout.scrollDirection = UICollectionViewScrollDirectionVertical;
   // 根据布局类 创建UICollectionView
   UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
   cv.backgroundColor = [UIColor whiteColor];
   [self.view addSubview: cv];
   // 注册cell
   // UICollectionViewCell必须先注册cell
   [cv registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   // 注册分区头
   [cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
   cv.delegate = self;
   cv.dataSource = self;
   
}

#pragma mark -- UICollectionView代理方法

//返回item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return _hotArray.count / 2;
}

//返回item样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   // 数组倒序
   _hotArray = (NSMutableArray *)[[_hotArray reverseObjectEnumerator] allObjects];
   GiftHotModal *hot = [_hotArray objectAtIndex:indexPath.row];
   [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[hot.data valueForKey:@"cover_image_url"]] placeholderImage:[UIImage imageNamed:@"cacheImage3"]];
   cell.nameStr.text = [hot.data valueForKey:@"name"];
   NSString *str = @"￥";
   NSString *str1 = [str stringByAppendingString:[hot.data valueForKey:@"price"]];
   cell.priceLabel.text = str1;
   return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return CGSizeMake(self.view.frame.size.width / 2 - 20, 160);
}

//分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   return 1;
}
//点击item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   //NSLog(@"你点了第%ld分区的第%ld个item",indexPath.section,indexPath.row);
   HotDetailsViewController *hotDetails = [[HotDetailsViewController alloc] init];
   GiftHotModal *hot = [_hotArray objectAtIndex:indexPath.row];
   hotDetails.ID = [[hot.data valueForKey:@"id"] integerValue];;
   [self.navigationController pushViewController:hotDetails animated:YES];
}

// 懒加载
- (NSMutableArray *)hotArray
{
   if (!_hotArray) {
      self.hotArray = [NSMutableArray array];
   }
   return _hotArray;
}
- (NSMutableArray *)ArcArray
{
   if (!_ArcArray) {
      _ArcArray = [NSMutableArray array];
   }
   return _ArcArray;
}


// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"心意礼物"];
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
