//
//  BAlertView.m
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BAlertModal.h"
#import "BAlertViewConfig.h"
#import "UIView+BAlertModel.h"

//NSString *const bAlertModelViewKey = @"bAlertModelViewKey";
//NSString *const bAlertModelDisplayStyleKey = @"bAlertModelDisplayStyleKey";




//==============view BAlertModal================

@interface BAlertModal()


@end


@implementation BAlertModal


+ (BAlertModal*)sharedInstance{
    static BAlertModal *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        _viewManager = [BAlertViewManager manager];
        _toastManager = [BAlertToastManager manager];
        
    }
    return self;
}

//MARK: -  Toast


-(void)makeToast:(NSString*)message{
    [self makeToast:message disPlayStyle:BAlertModalToastBottom];
}

-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style{
    [self makeToast:message disPlayStyle:style showTime:BAlertModalToastshort];
}

-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style showTime:(BAlertModalToastDisPlayTime)showTime{
    [self.toastManager makeToast:message disPlayStyle:style showTime:showTime];
}


//MARK: -  showAlerView



-(void)showAlerView:(UIView *)view{
    [self showAlerView:view disPlayStyle:BAlertModalViewCenter animated:YES];
}

-(void)showAlerView:(UIView *)view  animated:(BOOL)animated{
   [self showAlerView:view disPlayStyle:BAlertModalViewCenter animated:animated];
}
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style{
    [self showAlerView:view disPlayStyle:style animated:YES];
}
-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated{
  
    [self showAlerView:view disPlayStyle:style animated:animated completionBlock:nil];
}

-(void)showAlerView:(UIView *)view showAnimationBlock:(BAlertModelshowAnimationBlock)showAnimationBlock hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock{
    view.b_showBlock = showAnimationBlock;
    view.b_hideBlock = hideAnimationBlock;
    [self showAlerView:view disPlayStyle:BAlertViewAnimateCustom];
}



-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated completionBlock:(void(^)(void))completion{
    [self.viewManager showAlerView:view disPlayStyle:style animated:animated completionBlock:completion];
}




//MARK: -  hideAlertView



- (void)hide{
    [self.viewManager hide];
}

- (void)hideWithCompletionBlock:(void(^)(void))completion{
    [self.viewManager hideWithCompletionBlock:completion];
}

- (void)hideAnimated:(BOOL)animated{
    [self.viewManager hideAnimated:animated];
}

- (void)hideAnimated:(BOOL)animated completionBlock:(void(^)(void))completion{
    [self.viewManager hideAnimated:animated completionBlock:completion];
}



-(void)hideView:(UIView *)view hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock{
    view.b_hideBlock = hideAnimationBlock;
    [self hideView:view animated:YES completionBlock:nil];
}
- (void)hideView:(UIView *)view animated:(BOOL)animated  completionBlock:(void(^)(void))completion{
    [self.viewManager hideView:view animated:animated completionBlock:completion];
}




- (void)hideAll{
    [self.viewManager hideAll];
}






//MARK: -  private


-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [self.viewManager setBackgroundColor:backgroundColor];
}

-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
    [self.viewManager setShouldTapOutSideClosed:shouldTapOutSideClosed];
}

-(void)setAlertViewPrefersStatusBarHidden:(BOOL)alertViewPrefersStatusBarHidden{
    [self.viewManager setAlertViewPrefersStatusBarHidden:alertViewPrefersStatusBarHidden];
}

-(void)setAletViewPreferredStatusBarStyle:(UIStatusBarStyle)aletViewPreferredStatusBarStyle{
    [self.viewManager setAletViewPreferredStatusBarStyle:aletViewPreferredStatusBarStyle];
}
@end
