//
//  BAlertViewManager.h
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertConfig.h"

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





typedef void(^BAlertModelshowAnimationBlock)(UIView *view);
typedef NSTimeInterval (^BAlertModelHideAnimationBlock)(UIView *view);

typedef void(^BAlertModelshowCompletionBlock)(void);
typedef void(^BAlertModelHideCompletionBlock)(void);








@interface BAlerterViewController : UIViewController

@property(nonatomic,readwrite,retain)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;
@property(nonatomic,readwrite,retain) UIButton *backBtn;

@property (nonatomic,strong) NSMutableArray *viewsArray;

@end

@interface BAlertViewManager : NSObject


///view的背景颜色
@property(nonatomic,retain,readwrite)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;

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

