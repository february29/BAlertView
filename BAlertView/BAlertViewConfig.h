//
//  BAlertViewConfig.h
//  BAlertviewDemo
//
//  Created by edz on 2020/5/26.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BAlertModalViewDisPlayStyle){
    BAlertModalViewNone,// 位置根据传入的view frame决定
    BAlertModalViewCenter,//默认中间 宽高自定
    BAlertModalViewBottom ,//底部 宽度高度自定 window不缩小
    BAlertModalViewBottom2,//底部 window 缩小
    BAlertModalViewLeftMove,//从左侧移动过来
    BAlertModalViewLeftMove2,//从左侧移动过来 keyWindow跟随移动
    BAlertModalViewRightMove,//从右侧移动过来
    BAlertModalViewRightMove2,//从右侧移动过来 keyWindow跟随移动
    BAlertModalViewDropList, //下拉样式显示
    BAlertViewAnimateCustom // 自定义 尚需完善
   
    
};


NS_ASSUME_NONNULL_BEGIN



@interface BAlertViewConfig : NSObject



@property (nonatomic,assign) CGFloat alertViewAnimateDuration;

@property (nonatomic,strong) UIColor *alertViewBackGroundColor;


@property (nonatomic,assign) BOOL alertViewShouldTapOutsideClosed;

@property (nonatomic,assign) BOOL alertViewPrefersStatusBarHidden;

@property (nonatomic,assign) UIStatusBarStyle alertViewPreferredStatusBarStyle;


//默认配置
+(instancetype) defaultConfig;




@end

NS_ASSUME_NONNULL_END
