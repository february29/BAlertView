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

typedef void(^BAlertModelshowAnimationBlock)(UIView *view);
typedef NSTimeInterval (^BAlertModelHideAnimationBlock)(UIView *view);

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

//隐藏 最后show出来的View
- (void)hide;
- (void)hideWithCompletionBlock:(void(^)(void))completion;
- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated completionBlock:(void(^)(void))completion;

//如果出现二次弹窗时 隐藏所有的弹窗
- (void)hideAll;

//隐藏特定View 待完善
//-(void)hideView:(UIView *)view;




// 自定义 动画显示隐藏 （隐藏动画一起传入 因为如果用户点击外部隐藏时 如果无隐藏动画只能无动画隐藏）
-(void)showAlerView:(UIView *)view showAnimationBlock:(BAlertModelshowAnimationBlock)showAnimationBlock hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock;

//-(void)hideView:(UIView *)view hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock;





@end
