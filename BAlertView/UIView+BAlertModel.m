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









@end
