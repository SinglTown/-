//
//  IndexGuideMap.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexGuideMap.h"
#import "UIImageView+WebCache.h"
#import "downLoadData.h"
#import "IndexMaps.h"
@interface IndexGuideMap ()
{
   NSMutableArray *imgUrlArray;
   NSMutableArray *titleArray;
}

@property(nonatomic, strong)NSMutableArray *mapsArray;
@end

@implementation IndexGuideMap

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // 调用视图的方法
      [self createMyView];
   }
   return self;
}

// 创建视图的方法
- (void)createMyView
{
   imgUrlArray = [NSMutableArray array];
   titleArray = [NSMutableArray array];
   [self downLoadThePage];
   UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
   label.backgroundColor = [UIColor whiteColor];
   [self addSubview:label];
   
}

// 解析

- (void)downLoadThePage
{
   // 创建downLoad对象
   downLoadData *downLoad = [[downLoadData alloc] init];
   [downLoad downLoadDataWithUrlString:kGiftMapURL];
   downLoad.result = ^(NSData *data,BOOL isNetworking){
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         NSArray *array = [resultDic objectForKey:@"promotions"];
         
         for (NSDictionary *dic in array) {
            IndexMaps *maps = [[IndexMaps alloc] init];
            [maps setValuesForKeysWithDictionary:dic];
            [self.mapsArray addObject:maps];
            NSString *str = maps.icon_url;
            [imgUrlArray addObject:str];
            NSString *str1 = maps.title;
            [titleArray addObject:str1];
            
         }
         UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 / 2 - 25, 50, 50, 20)];
         label1.text = titleArray[0];
         label1.font = [UIFont systemFontOfSize:12];
         UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 + self.frame.size.width / 4 / 2 - 25, 50, 50, 20)];
         label2.text = titleArray[1];
         label2.font = [UIFont systemFontOfSize:12];
         
         UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 2 + self.frame.size.width / 4 / 2 - 25, 50, 50, 20)];
         label3.text = @"心意礼物";
         label3.font = [UIFont systemFontOfSize:12];
         
         UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 3 + self.frame.size.width / 4 / 2 - 25, 50, 50, 20)];
         label4.text = @"发现礼物";
         label4.font = [UIFont systemFontOfSize:12];
         
         
         UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 / 2 - 20, 5, 40, 40)];
         UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 + self.frame.size.width / 4 / 2 - 20, 5, 40, 40)];
         
         UIImageView *imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 2 + self.frame.size.width / 4 / 2 - 20, 5, 40, 40)];
         
         
         UIImageView *imageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * 3 + self.frame.size.width / 4 / 2 - 20, 5, 40, 40)];
         UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
         button4.frame = CGRectMake(220, 5, 40, 40);
         button4.showsTouchWhenHighlighted = YES;
         [imageV1 sd_setImageWithURL:[NSURL URLWithString:imgUrlArray[0]]];
         [imageV2 sd_setImageWithURL:[NSURL URLWithString:imgUrlArray[1]]];
         [imageV3 sd_setImageWithURL:[NSURL URLWithString:imgUrlArray[2]]];
         imageV4.image = [UIImage imageNamed:@"map4"];
         
         [self addSubview:button4];
         [self addSubview:imageV1];
         [self addSubview:imageV2];
         [self addSubview:imageV3];
         [self addSubview:imageV4];
         [self addSubview:label1];
         [self addSubview:label2];
         [self addSubview:label3];
         [self addSubview:label4];

      } else {
         
      }
   };
   
   
   
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
