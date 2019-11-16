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

@end

NS_ASSUME_NONNULL_END
