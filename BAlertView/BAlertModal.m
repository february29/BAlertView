//
//  BAlertView.m
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "BAlertModal.h"
#import <UIKit/UIKit.h>
#import "BAlertConfig.h"

//#define VMSCW [UIScreen mainScreen].bounds.size.width
//#define VMSCH [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger,BAlertViewAnimateType){
    BAlertViewAnimateCenter,
    BAlertViewAnimateBottom,
    BAlertViewAnimateBottom2,
    BAlertViewAnimateDropList,
    BAlertViewAnimateLeftMove
    
};

//==============tostlable================
@interface BToastLable : UILabel
@end
@implementation BToastLable

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {2, 5, 2, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end


//==============view viewController================
@interface BAlerterViewController : UIViewController
@property(nonatomic,readwrite,retain)UIColor *backgroundColor;
@property(nonatomic)BOOL shouldTapOutSideClosed;
@property(nonatomic,readwrite,retain) UIButton *backBtn;
@end

@implementation BAlerterViewController
-(void)viewDidLoad{
    
     _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSCW, MSCH)];
    [_backBtn addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
    
   
    [_backBtn setBackgroundColor:_backgroundColor];
    [self.view addSubview:_backBtn];
}
//ios8 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return BAlertViewAPPStatusBarHidden; // 返回NO表示要显示，返回YES将hiden
}
- (UIStatusBarStyle)preferredStatusBarStyle{
   
    return [UIApplication sharedApplication].statusBarStyle;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    if(_backgroundColor != backgroundColor){
        _backgroundColor = backgroundColor;
        [_backBtn setBackgroundColor:backgroundColor];
    }
    
    
}

//-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
//    
//    _shouldTapOutSideClosed = shouldTapOutSideClosed;
//    if (shouldTapOutSideClosed) {
//        [_backBtn addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
//    }else{
//        
//        [_backBtn removeTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
// 
//    }
//   
//}
-(void)dimiss{
    
    if (self.shouldTapOutSideClosed) {
         [[BAlertModal sharedInstance] hide];
    }
   
}
@end

//==============view BAlertModal================
static BToastLable *toastView = nil;

@interface BAlertModal(){
    UIWindow *window;
    BAlerterViewController *viewController;
    UIView *contentView;
    BAlertModalViewDisPlayStyle viewDisPlayStyle;
    
    UIWindow *delegateWindow;
}
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
        self.shouldTapOutSideClosed = YES;
        delegateWindow =  [[[UIApplication sharedApplication] delegate] window];
    }
    return self;
}
-(void)makeToast:(NSString*)message{
    [self makeToast:message disPlayStyle:BAlertModalToastBottom];
}

-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style{
    [self makeToast:message disPlayStyle:style showTime:BAlertModalToastshort];
}



-(void)makeToast:(NSString *)message disPlayStyle:(BAlertModalToastDisPlayStyle)style showTime:(BAlertModalToastDisPlayTime)showTime{
    
   
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self makeToast:message disPlayStyle:style showTime:showTime];
        });
        return;
    }
    @synchronized(self){
        if (toastView == nil) {
            toastView = [[BToastLable alloc] init];
            toastView.backgroundColor = BAlertToastBackGrond;
            toastView.textColor = BAlertToastTextColor;
            toastView.font = [UIFont systemFontOfSize:BAlertToastFont];
            toastView.layer.masksToBounds = YES;
            toastView.layer.cornerRadius = 4.0f;
            toastView.textAlignment = NSTextAlignmentCenter;
            toastView.alpha = 0;
            toastView.numberOfLines = 0;
            toastView.lineBreakMode = NSLineBreakByCharWrapping;
            [[UIApplication sharedApplication].keyWindow addSubview:toastView];
        }
    }
    if (toastView.superview != [UIApplication sharedApplication].keyWindow) {
        [toastView removeFromSuperview];
        [delegateWindow makeKeyAndVisible];
        [[UIApplication sharedApplication].keyWindow addSubview:toastView];
    }
    
   
    
    CGFloat width = [self stringText:message font:BAlertToastFont isHeightFixed:YES fixedValue:30]+10;
    CGFloat height = 30;
    if (width > MSCW - 20) {
        width = MSCW - 20;
        height = [self stringText:message font:BAlertToastFont isHeightFixed:NO fixedValue:width]+4;
    }
    

    CGRect frame ;
    if (style == BAlertModalToastTop) {
        frame  = CGRectMake((MSCW-width)/2,MSCH*0.15, width, height);
    }else if (style == BAlertModalToastCenter){
        frame  = CGRectMake((MSCW-width)/2,(MSCH-height)/2, width, height);
    }else{
        frame  = CGRectMake((MSCW-width)/2,MSCH*0.90-height, width, height);
    }
    toastView.alpha = 1;
    toastView.text = message;
    toastView.frame = frame;
    
    float time =  showTime==BAlertModalToastshort?2.0f:4.0f;
    [UIView animateWithDuration:time animations:^{
        toastView.alpha = 0;
    } completion:^(BOOL finished) {
        [toastView removeFromSuperview];
    }];

}


//根据字符串长度获取对应的宽度或者高度
-(CGFloat)stringText:(NSString *)text font:(CGFloat)font isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue
{
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize;
    //返回计算出的size
    resultSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil].size;
    
    if (isHeightFixed) {
        return resultSize.width;
    } else {
        return resultSize.height;
    }
}


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


-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated completionBlock:(void(^)())completion{
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        
        
    }
    
    if (!viewController) {
        viewController = [[BAlerterViewController alloc] init];;
        viewController.backgroundColor = _backgroundColor?_backgroundColor:BAlertViewBackGroundColor;
        viewController.shouldTapOutSideClosed = _shouldTapOutSideClosed;
    }
    window.rootViewController = viewController;
    
    contentView = view;
    [viewController.view addSubview:contentView];
    
    
    contentView.hidden = YES;
    viewDisPlayStyle = style;
    switch (viewDisPlayStyle) {
        case BAlertModalViewNone :
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateCenter completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            
            break;
        }
        case BAlertModalViewBottom :
        {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateBottom completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            break;
        }
        case BAlertModalViewBottom2 :
        {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateBottom2 completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            break;
        }
        case BAlertModalViewCenter :
        {
            
            contentView.center = viewController.view.center;
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateCenter completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            
            
            break;
            
        }
        case BAlertModalViewDropList:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateDropList completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            
            break;
        }
            
        case BAlertModalViewLeftMove:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [window makeKeyAndVisible];
                if(animated){
                    [self viewShowAnimateWithAnimateType:BAlertViewAnimateLeftMove completionBlock:completion];
                }
                contentView.hidden = NO;
            });
            
            break;
        }
            
            
        default:
            break;
    }
    
    
    

}


-(void)viewShowAnimateWithAnimateType:(BAlertViewAnimateType)animateType completionBlock:(void(^)())completion{
    switch (animateType) {
        case BAlertViewAnimateBottom2:
        {
            delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
               delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            }];
            
        }
        case BAlertViewAnimateBottom:
        {
            
            CGRect newRct =     contentView.frame ;
            newRct.size.width = MSCW;
            newRct.origin.x = 0;
            newRct.origin.y = MSCH; //开始的时候在屏幕下方
            contentView.frame = newRct;
            contentView.alpha = 0.1f;
            contentView.hidden = NO;
            
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                CGRect newRct = contentView.frame ;
                newRct.origin.y = MSCH-newRct.size.height;
                contentView.frame = newRct;
                contentView.alpha = 1.0f;
                
                if (completion) {
                    completion();
                }
                
            }];
            
            
            break;
        }
        case BAlertViewAnimateCenter:
        {
            contentView.hidden = NO;
            contentView.alpha = 0;
            contentView.layer.shouldRasterize = YES;
            contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                contentView.alpha = 1;
                contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    contentView.alpha = 1;
                    contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
                    contentView.layer.shouldRasterize = NO;
                    if (completion) {
                        completion();
                    }

                    
                }];
            }];
            
            break;
        }
        case BAlertViewAnimateDropList:
        {
            contentView.hidden = NO;
            float tableH = contentView.frame.size.height;
            contentView.alpha = 0.0f;
            CGRect frame = contentView.frame;
            frame.size.height = 0;
            contentView.frame = frame;
            frame.size.height = tableH;
            [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            contentView.frame = frame;
            contentView.alpha = 1;
            [UIView commitAnimations];
            if (completion) {
                completion();
            }

            
            break;
        }
        case BAlertViewAnimateLeftMove:
        {
            contentView.hidden = NO;
            contentView.alpha = 0;
            
            
            contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -contentView.frame.size.width, 0);
            
            
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                contentView.alpha = 1;
                contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            } completion:^(BOOL finished) {
                contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                if (completion) {
                    completion();
                }

            }];
            
            
            
            break;
        }
            
            
            
        default:
            break;
    }

}


-(void)viewShowAnimateWithAnimateType:(BAlertViewAnimateType)animateType {
   
    [self viewShowAnimateWithAnimateType:animateType completionBlock:nil];
}

- (void)hide{
    [self hideAnimated:YES];
}

- (void)hideWithCompletionBlock:(void(^)())completion{
    [self hideAnimated:YES withCompletionBlock:completion];
}

- (void)hideAnimated:(BOOL)animated{
    [self hideAnimated:animated withCompletionBlock:nil];
}

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion{
   
    [self hideAnimated:animated hideWindow:YES withCompletionBlock:completion];
    
    
}


- (void)hideAnimated:(BOOL)animated hideWindow:(BOOL )hiddeWindow withCompletionBlock:(void(^)())completion{
    
    if(!animated){
        [self cleanup:hiddeWindow];
        return;
    }
    
    switch (viewDisPlayStyle) {
            
        case BAlertModalViewBottom2 :
        {
            
           
            delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            }];

        }
        case BAlertModalViewBottom :
        {
            
            if (hiddeWindow) {
                
                [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                    viewController.backBtn.alpha = 0;
                }];
                
            }
            
            
            
            contentView.layer.shouldRasterize = YES;
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                CGRect newRct = contentView.frame ;
                newRct.origin.y = MSCH;
                contentView.frame = newRct;
                contentView.alpha = 0.8f;
            } completion:^(BOOL finished) {
                [contentView removeFromSuperview];
                [self cleanup:hiddeWindow];
                
                if(completion){
                    completion();
                }
            }];
            
            break;
        }
        case BAlertModalViewDropList:
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (hiddeWindow) {
                    [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                        viewController.backBtn.alpha = 0;
                    }];
 
                }
                
                contentView.layer.shouldRasterize = YES;
                
                [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    contentView.alpha = 0;
                    //contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                    
                    
                } completion:^(BOOL finished2){
                    [self cleanup:hiddeWindow];
                    if(completion){
                        completion();
                    }
                    
                    
                }];
                
            });
            
            
            //            [UIView animateWithDuration:0.35f animations:^{
            //
            //                CGRect sf = self.frame;
            //                sf.size.height = 30;
            //                self.frame = sf;
            //                CGRect frame = tv.frame;
            //                frame.size.height = 0;
            //                tv.frame = frame;
            //
            //            }];
            
            break;
        }
            
        case BAlertModalViewLeftMove:{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (hiddeWindow) {
                    [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                        viewController.backBtn.alpha = 0;
                    }];
                    
                }
                
                contentView.alpha = 1;
                contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, 0);
                
                
                
                
                [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                    contentView.alpha = 0;
                    contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -contentView.frame.size.width, 0);
                } completion:^(BOOL finished) {
                    
                    [self cleanup:hiddeWindow];
                    if(completion){
                        completion();
                    }
                    
                }];
                
            });
            
            
            break;
        }
            
        default:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (hiddeWindow) {
                    [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                        viewController.backBtn.alpha = 0;
                    }];
                    
                }

                
                contentView.layer.shouldRasterize = YES;
                [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                    contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                } completion:^(BOOL finished){
                    [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        contentView.alpha = 0;
                        contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                    } completion:^(BOOL finished2){
                        [self cleanup:hiddeWindow];
                        if(completion){
                            completion();
                        }
                        
                    }];
                }];
            });
            
            break;
        }
            
    }

    
}


- (void)cleanup{
    [self cleanup:YES];
}

- (void)cleanup:(BOOL )hideWindow{
    
    

    
    [contentView removeFromSuperview];
   
    
    if (hideWindow) {
        
        
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
       
       
        viewController = nil;
        [window removeFromSuperview];
        window = nil;
        self.backgroundColor = BAlertViewBackGroundColor;
        self.shouldTapOutSideClosed = BAlertViewShouldTapOutsideClosed;
    }else{
        //还原为默认
        self.backgroundColor = BAlertViewBackGroundColor;
        self.shouldTapOutSideClosed = BAlertViewShouldTapOutsideClosed;
    }
    
    
}



-(void)setBackgroundColor:(UIColor *)backgroundColor{

    if (_backgroundColor !=backgroundColor) {
        _backgroundColor = backgroundColor;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 viewController.backgroundColor = _backgroundColor?_backgroundColor:BAlertViewBackGroundColor;
        viewController.backgroundColor = backgroundColor;

    }
    

    
}

-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
    if(_shouldTapOutSideClosed != shouldTapOutSideClosed){
        _shouldTapOutSideClosed = shouldTapOutSideClosed;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面
        viewController.shouldTapOutSideClosed = shouldTapOutSideClosed;
    }

}
@end
