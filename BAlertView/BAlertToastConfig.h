//
//  BAlertToastConfig.h
//  BAlertviewDemo
//
//  Created by edz on 2020/5/26.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,BAlertModalToastDisPlayStyle){
    BAlertModalToastTop,
    BAlertModalToastCenter,
    BAlertModalToastBottom
    
};

typedef NS_ENUM(NSInteger,BAlertModalToastDisPlayTime){
    BAlertModalToastLong, //4s
    BAlertModalToastshort //2s
   
    
};

NS_ASSUME_NONNULL_BEGIN

@interface BAlertToastConfig : NSObject


@property (nonatomic,assign) UIFont *tostFont;

@property (nonatomic,assign) CGFloat tostCornerRadius;


@property (nonatomic,strong) UIColor *toastBackGrondColor;
@property (nonatomic,strong) UIColor *toastTextColor;






//默认配置
+(instancetype) defaultConfig;

@end

NS_ASSUME_NONNULL_END
