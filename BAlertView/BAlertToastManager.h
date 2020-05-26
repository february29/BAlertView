//
//  BAletToastManager.h
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertToastConfig.h"



NS_ASSUME_NONNULL_BEGIN

@interface BToastLable : UILabel

@end

@interface BAlertToastManager : NSObject

//==============================全局配置====================
//全局配置使用BAlertToastConfig配置 配置后应用中所有吐司通用
//默认使用 [BAlertToastConfig defaultConfig]
@property (nonatomic,strong) BAlertToastConfig *config;

//==============================单次配置 尚需完善==================== 

+(instancetype)manager;

-(void)makeToast:(NSString*)message;

-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style;


-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style showTime:(BAlertModalToastDisPlayTime)showTime;




@end

NS_ASSUME_NONNULL_END
