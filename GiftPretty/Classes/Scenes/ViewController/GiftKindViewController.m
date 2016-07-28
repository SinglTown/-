//
//  GiftKindViewController.m
//  PrettyGift
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "GiftKindViewController.h"
#import "NavTitleHelper.h"
#import "downLoadData.h"
#import "GiftKindModal.h"
#import "UIImageView+WebCache.h"
#import "KindChannelsModal.h"
#import "KindCollectionViewCell.h"
#import "KindStrategyModal.h"
#import "KindStrategyViewController.h"
@interface GiftKindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
   // 菊花小控件
   UIActivityIndicatorView *activity;
   //
   NSMutableArray *channelsArray;
   // UIImageView视图
   UIImageView *imageV;
}
@property (nonatomic, strong)NSMutableArray *kindArray;
@end

@implementation GiftKindViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   channelsArray = [NSMutableArray array];
   
   [self createTitleView];
   [self activityIndicatorViewLoad];
   [self downLoadThePage];
   
   // Do any additional setup after loading the view.
}
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"攻略分类"];
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

// 解析
- (void)downLoadThePage
{
   downLoadData *down = [[downLoadData alloc] init];
   [down downLoadDataWithUrlString:kGiftKindStrategyURL];
   down.result = ^(NSData *data, BOOL isNetworking){
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *AllDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *DataDic = [AllDataDic objectForKey:@"data"];
         NSArray *array = [DataDic objectForKey:@"collections"];
         for (NSDictionary *dic in array) {
            KindStrategyModal *strategy = [[KindStrategyModal alloc] init];
            [strategy setValuesForKeysWithDictionary:dic];
            [self.kindArray addObject:strategy];
         }
         [activity stopAnimating];
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

// 创建tableView
- (void)createCollectionView
{
   // 创建布局类
   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
   // 最小行间距
   layout.minimumLineSpacing = 10;
   // 最小列间距
   layout.minimumInteritemSpacing = 10;
   // 设置距离屏幕上左下右边距
   layout.sectionInset = UIEdgeInsetsMake(10, 10, 30, 10);
   // 设置滚动方向（垂直）
   layout.scrollDirection = UICollectionViewScrollDirectionVertical;
   // 根据布局类 创建UICollectionView
   UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
   cv.backgroundColor = [UIColor whiteColor];
   [self.view addSubview: cv];
   // 注册cell
   // UICollectionViewCell必须先注册cell
   [cv registerClass:[KindCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   cv.delegate = self;
   cv.dataSource = self;
   
   [self createLabelView];
}

- (void)createLabelView
{
   imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
   UIImage *image = [UIImage imageNamed:@"1"];
   imageV.image = image;
   imageV.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:210/255.0 alpha:1];
   imageV.layer.borderWidth = 0.3;
   imageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
   // 开启imageV的交互事件，默认用户交互事件关闭状态
   imageV.userInteractionEnabled = YES;
   [self.view addSubview:imageV];
   
   UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, self.view.frame.size.width - 10, 40)];
   label.text = @"专题展示";
   
   [imageV addSubview:label];
   // 调用逐帧动画方法
   [self imageVActiviting];
}
// 逐帧动画
- (void)imageVActiviting
{
   // 定义一个数组，用来装逐帧图片
   NSMutableArray *array = [NSMutableArray array];
   // 逐帧动画第一步 获取所有图片 并将图片装进数组
   for (int i = 1; i <= 6; i ++) {
      // 获取每张图片的名字
      NSString *name = [NSString stringWithFormat:@"%d",i];
      // 得到每一张图片
      UIImage *image = [UIImage imageNamed:name];
      // 将图片添加到数组
      [array addObject:image];
   }
   // 对动画的参数进行设置
   imageV.animationDuration = 1;    // 持续时间
   imageV.animationImages = array;  // 图片数组
   imageV.animationRepeatCount = 0; // 0代表无限重复
   
   // 开启动画
   [imageV startAnimating];
}


#pragma mark -- UICollectionView代理方法

//返回item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return _kindArray.count;
}

//返回item样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   KindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   KindStrategyModal *strategy = [self.kindArray objectAtIndex:indexPath.row];
  
   [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:strategy.banner_image_url] placeholderImage:[UIImage imageNamed:@"cacheImage2"]];
   return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return CGSizeMake(self.view.frame.size.width / 2 - 20, 80);
}

//点击item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   //NSLog(@"你点了第%ld分区的第%ld个item",indexPath.section,indexPath.row);
   KindStrategyViewController *strategy = [[KindStrategyViewController alloc] init];
   KindStrategyModal *strategyModal = [_kindArray objectAtIndex:indexPath.row];
   strategy.titleText = strategyModal.title;
   strategy.ID = strategyModal.id;
   [self.navigationController pushViewController:strategy animated:YES];
}

// 懒加载
- (NSMutableArray *)kindArray
{
   if (!_kindArray) {
      self.kindArray = [NSMutableArray array];
   }
   return _kindArray;
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


/* 本页中的一个没有写好的解析，留作备用
 NSError *error = nil;
 NSDictionary *AllDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
 NSDictionary *DataDic = [AllDataDic objectForKey:@"data"];
 NSArray *array = [DataDic objectForKey:@"channel_groups"];
 for (NSDictionary *dic in array) {
 GiftKindModal *kind = [[GiftKindModal alloc] init];
 [kind setValuesForKeysWithDictionary:dic];
 [self.kindArray addObject:kind];
 NSLog(@"%@",[kind.name valueForKey:@"name"]);
 // kind里边装两个字段  channels && name
 for (NSDictionary *diction in kind.channels) {
 KindChannelsModal *kindChannels = [[KindChannelsModal alloc] init];
 [kindChannels setValuesForKeysWithDictionary:diction];
 [channelsArray addObject:kindChannels];
 NSLog(@"%@",[kindChannels.icon_url valueForKey:@"icon_url"]);
 }
 }*/


@end
