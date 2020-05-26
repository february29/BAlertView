//
//  BAlertViewConfig.m
//  BAlertviewDemo
//
//  Created by edz on 2020/5/26.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import "BAlertViewConfig.h"

@implementation BAlertViewConfig

+(instancetype) defaultConfig{
    
    
    BAlertViewConfig *defaultConfig = [BAlertViewConfig new];
    
    defaultConfig.alertViewAnimateDuration = 0.3;
    defaultConfig.alertViewBackGroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    defaultConfig.alertViewShouldTapOutsideClosed = YES;
    defaultConfig.alertViewPrefersStatusBarHidden = NO;
    defaultConfig.alertViewPreferredStatusBarStyle =  [UIApplication sharedApplication].statusBarStyle;
    
    return defaultConfig;
}



@end
