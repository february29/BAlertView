//
//  UIView+BAlertModel.h
//  BAlertviewDemo

//  Created by edz on 2019/11/16.
//  Copyright © 2019 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertViewConfig.h"





NS_ASSUME_NONNULL_BEGIN




@interface UIView (BAlertModel)

//显示的样式
@property (nonatomic,assign) BAlertModalViewDisPlayStyle b_showStyle;

//隐藏样式
@property (nonatomic,assign) BAlertModalViewDisPlayStyle b_hideStyle;

//alertview状态
@property (nonatomic,assign) BAlertViewState b_alertViewState;

//view配置
//@property (nonatomic,strong) BAlertViewConfig *b_alertViewConfig;



/// 显示动画block
@property (nonatomic,copy) BAlertModelshowAnimationBlock b_showBlock;

/// 隐藏动画block
@property (nonatomic,copy) BAlertModelHideAnimationBlock b_hideBlock;


/// 显示动画完毕后执行block
@property (nonatomic,copy) BAlertModelshowCompletionBlock b_showCompletionBlock;

/// 隐藏动画完毕后执行block
@property (nonatomic,copy) BAlertModelHideCompletionBlock b_hideCompletionBlock;






/// 点击外部按钮隐藏完毕后执行的block （点击外部隐藏最后一个，所以执行的是最有一个view的block）
@property (nonatomic,copy) BAlertModelHideCompletionBlock b_tapOutsideHideCompletionBlock ;
//__attribute__((deprecated("first deprecated in 1.1.8 - Use `b_hideCompletionBlock` property")))


//⚠️ 使用 BAlertViewManager 中 show hide方法时
//⚠️ 如果传递completionBlock参数将会覆盖b_showCompletionBlock或者b_hideCompletionBlock
//⚠️ 如果不传递completionBlock参数会执行b_showCompletionBlock或者b_hideCompletionBlock
//⚠️ 设置b_tapOutsideHideCompletionBlock后 点击外部隐藏时 会将b_hideCompletionBlock覆盖替换 原有b_hideCompletionBlock将丢失。



@end

NS_ASSUME_NONNULL_END
