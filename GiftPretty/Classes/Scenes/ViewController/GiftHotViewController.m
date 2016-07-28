//
//  GiftHotViewController.m
//  PrettyGift
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "GiftHotViewController.h"
#import "NavTitleHelper.h"
#import "downLoadData.h"
#import "GiftHotModal.h"
#import "HotCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HotDetailsViewController.h"
// 下拉刷新
#import "CCEaseRefresh.h"
// 上拉加载
#import "SDRefresh.h"
@interface GiftHotViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
   // 菊花小控件
   UIActivityIndicatorView *activity;
   
   UITableView *tab;
   
   // 记录item的图片数组
   NSMutableArray *itemArray;
   UICollectionView *cv;
}
// 下拉刷新属性
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
// 上拉加载
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, assign) NSInteger totalRowCount;
@property (nonatomic, strong)NSMutableArray *hotArray;
@end

@implementation GiftHotViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   itemArray = [NSMutableArray array];
   [self createTitleView];
   [self activityIndicatorViewLoad];
   [self downLoadThePage];
   
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
// 导航栏标题
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"热门礼物"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}

// 解析
- (void)downLoadThePage
{
   downLoadData *down = [[downLoadData alloc] init];
   [down downLoadDataWithUrlString:kGiftHotURL];
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
         _totalRowCount = 12;
         [activity stopAnimating];
         [self createCollectionView];
         // 下拉刷新
         [self setupHeader];
         // 上拉加载
         [self setupFooter];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
   };
   
}
- (void)setupHeader
{
   SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
   // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
   [refreshHeader addToScrollView:cv];
   __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
   //__weak typeof(self) weakSelf = self;
   refreshHeader.beginRefreshingOperation = ^{
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         if (sleep(0.5)) {
            [cv reloadData];
         }
         [weakRefreshHeader endRefreshing];
      });
   };
   
   // 进入页面自动加载一次数据
   [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)setupFooter
{
   SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
   [refreshFooter addToScrollView:cv];
   [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
   _refreshFooter = refreshFooter;
}

- (void)footerRefresh
{
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      if (_totalRowCount < 90) {
         _totalRowCount +=10;
         [self.refreshFooter endRefreshing];
         [cv reloadData];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"数据已经全部加载完" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
         [self.refreshFooter endRefreshing];
      }
      
   });
}


// 创建CollectionView
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
   cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) collectionViewLayout:layout];
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
   return _totalRowCount;
}

//返回item样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   GiftHotModal *hot = [_hotArray objectAtIndex:indexPath.row];
   
   [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[hot.data valueForKey:@"cover_image_url"]] placeholderImage:[UIImage imageNamed:@"cacheImage"]];
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

//分区高度
/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   return CGSizeMake(self.view.frame.size.width, 40);
}
*/

//自定义分区
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   if (kind == UICollectionElementKindSectionHeader) {
      UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
      headerView.backgroundColor = [UIColor cyanColor];
      return headerView;
   }
   return nil;
}*/

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
