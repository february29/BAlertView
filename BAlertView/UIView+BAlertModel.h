//
//  UIView+BAlertModel.h
//  BAlertviewDemo
//
//  Created by edz on 2019/11/16.
//  Copyright © 2019 bai.xianzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAlertModal.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BAlertModel)

@property (nonatomic,assign) BAlertModalViewDisPlayStyle b_showStyle;
@property (nonatomic,assign) BAlertModalViewDisPlayStyle b_hideStyle;


/// 显示动画block
@property (nonatomic,copy) BAlertModelshowAnimationBlock b_showBlock;

/// 隐藏动画block
@property (nonatomic,copy) BAlertModelHideAnimationBlock b_hideBlock;


/// 显示动画完毕后执行block
@property (nonatomic,copy) BAlertModelshowCompletionBlock b_showCompletionBlock;

/// 隐藏动画完毕后执行block
@property (nonatomic,copy) BAlertModelHideCompletionBlock b_hideCompletionBlock;



/// 点击外部按钮隐藏完毕后执行的block（点击外部隐藏最后一个，所以执行的是最有一个view的block）
@property (nonatomic,copy) BAlertModelHideCompletionBlock b_tapOutsideHideCompletionBlock;


@end

NS_ASSUME_NONNULL_END
