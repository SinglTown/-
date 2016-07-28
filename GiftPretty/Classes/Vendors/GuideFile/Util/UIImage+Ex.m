

//
//  Created by 徐东macbook on 15/9/5.
//  Copyright (c) 2015年 徐东macbook. All rights reserved.
//

#import "UIImage+Ex.h"

@implementation UIImage (Ex)

+ (UIImage *)imageWithFileName:(NSString *)filename ofType:(NSString *)ofType
{
    BOOL isRetina = [UIScreen mainScreen].scale>1;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:[filename stringByAppendingString:isRetina?@"@2x":@""] ofType:ofType];
    return [UIImage imageWithContentsOfFile:filepath];
}

@end
