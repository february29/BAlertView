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
    BAlertModalViewBottom ,//底部 view宽度与屏幕等宽，高度自定 window不缩小
    BAlertModalViewBottom2,//底部 window 缩小
    BAlertModalViewLeftMove,//从左侧移动过来
    BAlertModalViewLeftMove2,//从左侧移动过来 keyWindow跟随移动
    BAlertModalViewRightMove,//从右侧移动过来
    BAlertModalViewRightMove2,//从右侧移动过来 keyWindow跟随移动
    BAlertModalViewDropList, //下拉样式显示
    BAlertViewAnimateCustom // 自定义 尚需完善
   
    
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

@interface BToastLable : UILabel

@end

@interface BAlerterViewController : UIViewController

@property(nonatomic,readwrite,retain)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;
@property(nonatomic,readwrite,retain) UIButton *backBtn;

@end


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
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated completionBlock:(void(^)(void))completion;


//隐藏后 还原keywindow
- (void)hide;
- (void)hideWithCompletionBlock:(void(^)(void))completion;
- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)(void))completion;
//隐藏后 不还原keywindow  只是让contentviewer 消失  不常用
//- (void)hideAnimated:(BOOL)animated hideWindow:(BOOL )hiddeWindow withCompletionBlock:(void(^)(void))completion;

//如果出现二次弹窗时 隐藏所有的弹窗 待完善
- (void)hideAll;




@end
