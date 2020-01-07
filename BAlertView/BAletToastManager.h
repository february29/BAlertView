//
//  BAletToastManager.h
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertConfig.h"

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

@interface BToastLable : UILabel

@end

@interface BAletToastManager : NSObject

+(instancetype)manager;

-(void)makeToast:(NSString*)message;

-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style;


-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style showTime:(BAlertModalToastDisPlayTime)showTime;

@end

NS_ASSUME_NONNULL_END
