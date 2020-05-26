//
//  BAlertToastConfig.m
//  BAlertviewDemo
//
//  Created by edz on 2020/5/26.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import "BAlertToastConfig.h"

@implementation BAlertToastConfig


+(instancetype) defaultConfig{
    
    
    BAlertToastConfig *defaultConfig = [BAlertToastConfig new];
    
    defaultConfig.tostFont = [UIFont systemFontOfSize:14];
    defaultConfig.toastBackGrondColor = [UIColor blackColor];
    defaultConfig.toastTextColor = [UIColor whiteColor];
    defaultConfig.tostCornerRadius = 4.0f;
    return defaultConfig;
}


@end
