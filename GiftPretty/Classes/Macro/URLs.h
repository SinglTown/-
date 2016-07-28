//
//  URLs.h
//  MyMusic
//
//  Created by lanou3g on 15/9/22.
//  Copyright © 2015年 徐东. All rights reserved.
//

#ifndef URLs_h
#define URLs_h

// 首页接口
#define kGiftIndexListURL @"http://api.liwushuo.com/v2/channels/100/items?limit=50"
// 首页Banners的接口
#define KGiftIndexBannersURL @"http://api.liwushuo.com/v2/banners"
// 首页banner下边的选择按钮接口
#define kGiftMapURL @"http://api.liwushuo.com/v2/promotions?gender=1&generation=1"
// 礼物搜索
#define kGiftSearchURL @"http://m.liwuso.com/start"


//点击美好礼物：
//http://api.liwushuo.com/v2/collections/22/posts?limit=20&offset=0
//攻略专题：
//http://api.liwushuo.com/v1/collections?offset=0&limit=20



// 首页详情页接口
#define kGiftClickCellDetails @"http://api.liwushuo.com/v1/posts/"
// 热门页面接口
#define kGiftHotURL @"http://api.liwushuo.com/v2/items?limit=100"
#define kGiftHotURL2 @"http://api.liwushuo.com/v2/items?limit=20"
// 热门页面商品详情接口
#define kGiftHotDetailURL @"http://api.liwushuo.com/v2/items/"

// 分类页面
#define kGiftKindURL @"http://api.liwushuo.com/v2/channel_groups/all"

// 分类页面策略
#define kGiftKindStrategyURL @"http://api.liwushuo.com/v2/collections?limit=12&offset=0"

// 分类页面对应专题的接口
//#define kGiftKindStrategyURL @"http://api.liwushuo.com/v2/collections/136/posts?limit=20&offset=0"

#endif /* URLs_h */
