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
#import "BAletToastManager.h"
#import "BAlertViewManager.h"




@interface BAlertModal : NSObject

// MARK: - 属性

///view的背景颜色
@property(nonatomic,retain,readwrite)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;


// MARK: - 方法
+ (instancetype)sharedInstance;

//  ============toast===========

-(void)makeToast:(NSString*)message;
-(void)makeToast:(NSString*)message disPlayStyle:(BAlertModalToastDisPlayStyle) style;
-(void)makeToast:(NSString*)message disPlayStyle:(BAlertModalToastDisPlayStyle) style showTime:(BAlertModalToastDisPlayTime)showTime;

//  ============view===========



-(void)showAlerView:(UIView *)view;
-(void)showAlerView:(UIView *)view  animated:(BOOL)animated;
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style;
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated;
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated completionBlock:(void(^)(void))completion;

//隐藏 最后show出来的View
- (void)hide;
- (void)hideWithCompletionBlock:(void(^)(void))completion;
- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated completionBlock:(void(^)(void))completion;

//如果出现二次弹窗时 隐藏所有的弹窗
- (void)hideAll;

// 自定义 动画显示隐藏 （隐藏动画一起传入 因为如果用户点击外部隐藏时 如果无隐藏动画只能无动画隐藏）
-(void)showAlerView:(UIView *)view showAnimationBlock:(BAlertModelshowAnimationBlock)showAnimationBlock hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock;

//-(void)hideView:(UIView *)view hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock;






@end
