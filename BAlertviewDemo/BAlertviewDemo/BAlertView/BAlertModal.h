//
//  BAlertView.h
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//



#define BMAKETOAST(m) [[BAlertModal sharedInstance]makeToast:(m)];
#define BMAKECENTERTOAST(m) [[BAlertModal sharedInstance]makeToast:(m) disPlayStyle:BAlertModalToastCenter];
#define BMAKETOPTOAST(m) [[BAlertModal sharedInstance]makeToast:(m) disPlayStyle:BAlertModalToastTop];


//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BAlertModalViewDisPlayStyle){
    BAlertModalViewNone,// 位置根据传入的view frame决定
    BAlertModalViewCenter,//默认中间 宽高自定
    BAlertModalViewBottom //底部 view宽度与屏幕等宽，高度自定
   
    
};

typedef NS_ENUM(NSInteger,BAlertModalToastDisPlayStyle){
    BAlertModalToastTop,
    BAlertModalToastCenter,
    BAlertModalToastBottom
    
};

typedef NS_ENUM(NSInteger,BAlertModalToastDisPlayTime){
    BAlertModalToastLong, //4s
    BAlertModalToastshort //2s
   
    
};

@interface BAlertModal : NSObject

+ (instancetype)sharedInstance;

//  ============toast===========

-(void)makeToast:(NSString*)message;
-(void)makeToast:(NSString*)message disPlayStyle:(BAlertModalToastDisPlayStyle) style;
-(void)makeToast:(NSString*)message disPlayStyle:(BAlertModalToastDisPlayStyle) style showTime:(BAlertModalToastDisPlayTime)showTime;

//  ============view===========

///view的背景颜色
@property(nonatomic,retain,readwrite)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;

-(void)showAlerView:(UIView *)view;
-(void)showAlerView:(UIView *)view  animated:(BOOL)animated;
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style;
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated;

- (void)hide;
- (void)hideWithCompletionBlock:(void(^)())completion;
- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion;

@end
