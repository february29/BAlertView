//
//  BAlertViewManager.h
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertViewConfig.h"







typedef void(^BAlertModelshowAnimationBlock)(UIView *view);
typedef NSTimeInterval (^BAlertModelHideAnimationBlock)(UIView *view);

typedef void(^BAlertModelshowCompletionBlock)(void);
typedef void(^BAlertModelHideCompletionBlock)(void);









@interface BAlertViewManager : NSObject

//MARK:- 配置

//==============================全局配置====================
//全局配置使用BAlertViewConfig配置 配置后应用中所有弹窗通用
//默认 [BAlertViewConfig defaultConfig]
@property (nonatomic,strong) BAlertViewConfig *config;


//==============================单次配置====================

// view的背景颜色
@property(nonatomic,strong)UIColor *backgroundColor;

// 点击外部是否关闭
@property(nonatomic,assign)BOOL shouldTapOutSideClosed;

// 隐藏状态栏
@property (nonatomic,assign) BOOL alertViewPrefersStatusBarHidden;

// 状态栏样式
@property (nonatomic,assign) UIStatusBarStyle aletViewPreferredStatusBarStyle;



//MARK:- 属性

/// 记录显示出来view的array
@property (nonatomic,strong) NSMutableArray *showViewArray;




//MARK:- 方法

+(instancetype)manager;

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

- (void)hideView:(UIView *)view animated:(BOOL)animated  completionBlock:(void(^)(void))completion;

//如果出现二次弹窗时 隐藏所有的弹窗
- (void)hideAll;



// 自定义 动画显示隐藏 （隐藏动画一起传入 因为如果用户点击外部隐藏时 如果无隐藏动画只能无动画隐藏）
-(void)showAlerView:(UIView *)view showAnimationBlock:(BAlertModelshowAnimationBlock)showAnimationBlock hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock;

@end


@interface BAlerterViewController : UIViewController



@property(nonatomic,strong)UIColor *backgroundColor;

@property(nonatomic,assign)BOOL shouldTapOutSideClosed;

@property (nonatomic,assign) UIStatusBarStyle aletViewPreferredStatusBarStyle;

@property (nonatomic,assign) BOOL alertViewPrefersStatusBarHidden;

@property(nonatomic,strong) UIButton *backBtn;

//@property (nonatomic,strong) NSMutableArray *viewsArray;
@property (nonatomic,weak) BAlertViewManager *manager;

@end
