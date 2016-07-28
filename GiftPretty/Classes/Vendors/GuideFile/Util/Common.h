
//
//  Created by 徐东macbook on 15/9/5.
//  Copyright (c) 2015年 徐东macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

// Debug Logging
#if 1 // Set to 1 to enable debug logging
    #ifndef _DEBUG_LOG
        #define _DEBUG_LOG(x, ...) NSLog(x, ## __VA_ARGS__);
    #endif
#else
    #ifndef _DEBUG_LOG
        #define _DEBUG_LOG(x, ...)
    #endif
#endif


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IOS_7 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)

// safely release
#ifndef SAFE_RELEASE
#define SAFE_RELEASE(_x_) if(_x_){[_x_ release];_x_=nil;}
#endif



#ifndef IsiPhone5
#define IsiPhone5 CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(320, 568))
#endif

// index col row
#define GetColWithIndexRow(_index, _row) (_index/_row)
#define GetRowWithIndexRow(_index, _row) ((_index+_row)%_row)

#define GetColWithIndexCol(_index, _col) ((_index+_col)%_col)
#define GetRowWithIndexCol(_index, _col) (_index/_col)

#define DegreeToRadian(x) (x*M_PI/180.0)


