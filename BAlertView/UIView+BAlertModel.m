//
//  UIView+BAlertModel.m
//  BAlertviewDemo
//
//  Created by edz on 2019/11/16.
//  Copyright © 2019 bai.xianzhi. All rights reserved.
//

#import "UIView+BAlertModel.h"
#import <objc/runtime.h>


NSString *const bShowStyleKey = @"bShowStyleKey";
NSString *const bHideStyleKey = @"bHideStyleKey";
NSString *const bShowBlockKey = @"bShowBlockKey";
NSString *const bHideBlockKey = @"bHideBlockKey";
NSString *const bShowCompletionBlockKey = @"bShowCompletionBlockKey";
NSString *const bHideCompletionBlockKey = @"bHideCompletionBlockKey";
NSString *const bTapOutsideHideCompletionBlock = @"bTapOutsideHideCompletionBlock";

@implementation UIView (BAlertModel)




- (BAlertModalViewDisPlayStyle)b_showStyle{
    return [objc_getAssociatedObject(self, &bShowStyleKey) integerValue];
}
- (void)setB_showStyle:(BAlertModalViewDisPlayStyle)b_showStyle{
     objc_setAssociatedObject(self, &bShowStyleKey, @(b_showStyle), OBJC_ASSOCIATION_ASSIGN);
}



- (BAlertModalViewDisPlayStyle)b_hideStyle{
    return [objc_getAssociatedObject(self, &bHideStyleKey) integerValue];
}

-(void)setB_hideStyle:(BAlertModalViewDisPlayStyle)b_hideStyle{
    objc_setAssociatedObject(self, &bHideStyleKey, @(b_hideStyle), OBJC_ASSOCIATION_ASSIGN);
}


- (BAlertModelshowAnimationBlock)b_showBlock{
    return objc_getAssociatedObject(self, &bShowBlockKey);
}
-(void)setB_showBlock:(BAlertModelshowAnimationBlock)b_showBlock{
    objc_setAssociatedObject(self, &bShowBlockKey, b_showBlock, OBJC_ASSOCIATION_COPY);
}

- (BAlertModelHideAnimationBlock)b_hideBlock{
    return objc_getAssociatedObject(self, &bHideBlockKey);
}
-(void)setB_hideBlock:(BAlertModelHideAnimationBlock)b_hideBlock{
    objc_setAssociatedObject(self, &bHideBlockKey, b_hideBlock, OBJC_ASSOCIATION_COPY);
}


- (BAlertModelshowCompletionBlock)b_showCompletionBlock{
    return objc_getAssociatedObject(self, &bShowCompletionBlockKey);
}

-(void)setB_showCompletionBlock:(BAlertModelshowCompletionBlock)b_showCompletionBlock{
    objc_setAssociatedObject(self, &bShowCompletionBlockKey, b_showCompletionBlock, OBJC_ASSOCIATION_COPY);
}

-(BAlertModelHideCompletionBlock)b_hideCompletionBlock{
     return objc_getAssociatedObject(self, &bHideCompletionBlockKey);
}

-(void)setB_hideCompletionBlock:(BAlertModelHideCompletionBlock)b_hideCompletionBlock{
    objc_setAssociatedObject(self, &b_hideCompletionBlock, b_hideCompletionBlock, OBJC_ASSOCIATION_COPY);

}

- (BAlertModelHideCompletionBlock)b_tapOutsideHideCompletionBlock{
    return objc_getAssociatedObject(self, &bTapOutsideHideCompletionBlock);
}

-(void)setB_tapOutsideHideCompletionBlock:(BAlertModelHideCompletionBlock)b_tapOutsideHideCompletionBlock{
    objc_setAssociatedObject(self, &bTapOutsideHideCompletionBlock, b_tapOutsideHideCompletionBlock, OBJC_ASSOCIATION_COPY);
}






@end
