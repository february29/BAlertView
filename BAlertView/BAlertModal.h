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
#import "BAlertToastManager.h"
#import "BAlertViewManager.h"




@interface BAlertModal : NSObject

// MARK: - 属性

@property (nonatomic,strong) BAlertViewManager *viewManager;
@property (nonatomic,strong) BAlertToastManager *toastManager;



// 单次配置。 只配置最后显示的一次view。
//@property (nonatomic,strong) BAlertViewConfig *alertViewConfig;

//view的背景颜色
@property(nonatomic,strong)UIColor *backgroundColor;
// 点击外部隐藏
@property(nonatomic ,assign)BOOL shouldTapOutSideClosed;
// 隐藏状态栏
@property (nonatomic,assign) BOOL alertViewPrefersStatusBarHidden;

// 状态栏样式
@property (nonatomic,assign) UIStatusBarStyle aletViewPreferredStatusBarStyle;


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


// MARK: - ⚠️
// ⚠️  弹窗先时候 原始位置未记录， 弹窗消失后原始位置丢失。再次先试试位置可能混乱



@end
