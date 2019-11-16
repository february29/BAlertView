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
#import "UIView+BAlertModel.h"

//NSString *const bAlertModelViewKey = @"bAlertModelViewKey";
//NSString *const bAlertModelDisplayStyleKey = @"bAlertModelDisplayStyleKey";


//==============tostlable================

@implementation BToastLable

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {2, 5, 2, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end


//==============view viewController================


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


-(void)dimiss{
    
    if (self.shouldTapOutSideClosed) {
         [[BAlertModal sharedInstance] hide];
    }
   
}
@end

//==============view BAlertModal================
static BToastLable *toastView = nil;

@interface BAlertModal()

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) BAlerterViewController *viewController;
@property (nonatomic,strong) UIView *contentView;
//记录显示的view
@property (nonatomic,strong) NSMutableArray *showViewArray;
@property (nonatomic,assign) BAlertModalViewDisPlayStyle viewDisPlayStyle;

@property (nonatomic,strong) UIWindow *delegateWindow;

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
        _showViewArray = [NSMutableArray new];
        _delegateWindow =  [[[UIApplication sharedApplication] delegate] window];
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
        [_delegateWindow makeKeyAndVisible];
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


-(void)showAlerView:(UIView *)view disPlayStyle:(BAlertModalViewDisPlayStyle)style animated:(BOOL)animated completionBlock:(void(^)(void))completion{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _window.opaque = NO;
        
        
    }
    
    if (!_viewController) {
        _viewController = [[BAlerterViewController alloc] init];;
        _viewController.backgroundColor = _backgroundColor?_backgroundColor:BAlertViewBackGroundColor;
        _viewController.shouldTapOutSideClosed = _shouldTapOutSideClosed;
    }
    
     __weak typeof(self) wkself = self;
    
    _window.rootViewController = _viewController;
    _contentView = view;
    [_viewController.view addSubview:_contentView];
    
    //_showViewInfoArray  有内容证明 已经显示了 此时为二次弹窗 不需要动画
    if (animated && _showViewArray.count == 0 ) {
        wkself.viewController.backBtn.alpha = 0;
        [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
           wkself.viewController.backBtn.alpha = 1;
        }];
    }
       
    
    view.b_showStyle = style;
    view.b_hideStyle = style;
    [_showViewArray addObject:view];
    
    _contentView.hidden = YES;
    _viewDisPlayStyle = style;
    
    if (_viewDisPlayStyle == BAlertModalViewCenter) {
        _contentView.center = _viewController.view.center;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [wkself.window makeKeyAndVisible];
        if(animated){
            [wkself viewShowAnimateWithAnimateType:style completionBlock:completion];
        }
        wkself.contentView.hidden = NO;
    });
    
   
}

-(void)viewShowAnimateWithAnimateType:(BAlertModalViewDisPlayStyle)animateType {
   
    [self viewShowAnimateWithAnimateType:animateType completionBlock:nil];
}

-(void)viewShowAnimateWithAnimateType:(BAlertModalViewDisPlayStyle)animateType completionBlock:(void(^)(void))completion{
    
    
    
    __weak typeof(self) wkself = self;
    switch (animateType) {
        case BAlertModalViewBottom2:
        {
            wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            }];
            //这里没有Break 会执行下面的动画
        }
        case BAlertModalViewBottom:
        {
            
            CGRect newRct =     wkself.contentView.frame ;
            newRct.size.width = MSCW;
            newRct.origin.x = 0;
            newRct.origin.y = MSCH; //开始的时候在屏幕下方
            wkself.contentView.frame = newRct;
            wkself.contentView.alpha = 0.1f;
            wkself.contentView.hidden = NO;
            
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                CGRect newRct = wkself.contentView.frame ;
                newRct.origin.y = MSCH-newRct.size.height;
                wkself.contentView.frame = newRct;
                wkself.contentView.alpha = 1.0f;
                
                if (completion) {
                    completion();
                }
                
            }];
            
            
            break;
        }
        case BAlertModalViewCenter:
        {
            wkself.contentView.hidden = NO;
            wkself.contentView.alpha = 0;
            wkself.contentView.layer.shouldRasterize = YES;
            wkself.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    wkself.contentView.alpha = 1;
                    wkself.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
                    wkself.contentView.layer.shouldRasterize = NO;
                    if (completion) {
                        completion();
                    }

                    
                }];
            }];
            
            break;
        }
        case BAlertModalViewDropList:
        {
            wkself.contentView.hidden = NO;
            float tableH = wkself.contentView.frame.size.height;
            wkself.contentView.alpha = 0.0f;
            CGRect frame = wkself.contentView.frame;
            frame.size.height = 0;
            wkself.contentView.frame = frame;
            frame.size.height = tableH;
            [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            
            wkself.contentView.frame = frame;
            wkself.contentView.alpha = 1;
            [UIView commitAnimations];
            if (completion) {
                completion();
            }

            
            break;
        }
        case BAlertModalViewLeftMove2:{
            wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, wkself.contentView.frame.size.width, 0);
            }];
        }
        case BAlertModalViewLeftMove:
        {
            wkself.contentView.hidden = NO;
            wkself.contentView.alpha = 0;
            
            
            wkself.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -wkself.contentView.frame.size.width, 0);
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            } completion:^(BOOL finished) {
                wkself.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
                if (completion) {
                    completion();
                }

            }];
            
            
            
            break;
        }
        
        case BAlertModalViewRightMove2:{
            wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -wkself.contentView.frame.size.width, 0);
            }];
        }
        case BAlertModalViewRightMove:
        {
            wkself.contentView.hidden = NO;
            wkself.contentView.alpha = 0;
            
            wkself.contentView.transform = CGAffineTransformMakeTranslation(wkself.contentView.frame.size.width, 0);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
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



//MARK: -  hideAlertView



- (void)hide{
    [self hideView:[_showViewArray lastObject] animated:YES completionBlock:nil];
}

- (void)hideWithCompletionBlock:(void(^)(void))completion{
    [self hideView:[_showViewArray lastObject] animated:YES completionBlock:completion];
}

- (void)hideAnimated:(BOOL)animated{
    [self hideView:[_showViewArray lastObject] animated:animated completionBlock:nil];
}

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)(void))completion{
    [self hideView:[_showViewArray lastObject] animated:animated completionBlock:completion];
}


- (void)hideView:(UIView *)view animated:(BOOL)animated  completionBlock:(void(^)(void))completion{
    
    __weak typeof(self) wkself = self;
    
    //如果_showViewInfoArray只有1个，证明这是最后一个 背景做动画
    if ( animated && _showViewArray.count <= 1 ) {
        wkself.viewController.backBtn.alpha = 1;
        [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
           wkself.viewController.backBtn.alpha = 0;
        }];
    }
    
    
    if(!animated){
//         wkself.viewController.backBtn.alpha = 0;
        [wkself removeView:view];;
        return;
    }
    
   
 
    BAlertModalViewDisPlayStyle style = view.b_hideStyle;
  
    
    switch (style) {
            
        case BAlertModalViewBottom2 :
        {
            
           
            wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            }];

        }
        case BAlertModalViewBottom :
        {

            view.layer.shouldRasterize = YES;
            [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                CGRect newRct = view.frame ;
                newRct.origin.y = MSCH;
                view.frame = newRct;
                view.alpha = 0.8f;
            } completion:^(BOOL finished) {
                [wkself removeView:view];
                if(completion){
                    completion();
                }
            }];
            
            break;
        }
        case BAlertModalViewDropList:
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                view.layer.shouldRasterize = YES;
                
                [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    view.alpha = 0;
         
                } completion:^(BOOL finished2){
                    [wkself removeView:view];
                    if(completion){
                        completion();
                    }
                    
                    
                }];
                
            });
            

            break;
        }
        case BAlertModalViewLeftMove2:{
            
             wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, view.frame.size.width, 0);
             [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                 wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
             }];
        }
            
        case BAlertModalViewLeftMove:{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                view.alpha = 1;
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, 0);
     
                [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                    view.alpha = 0;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -view.frame.size.width, 0);
                } completion:^(BOOL finished) {
                    [wkself removeView:view];
                    if(completion){
                        completion();
                    }
                    
                }];
                
            });
            
            
            break;
        }
        case BAlertModalViewRightMove2:{
            
             wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -view.frame.size.width, 0);
             [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                 wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
             }];
        }
      
        case BAlertModalViewRightMove:{
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               
               view.alpha = 1;
               view.transform = CGAffineTransformIdentity;
//               contentView.transform = CGAffineTransformMakeTranslation(-contentView.frame.size.width, 0);
    
               [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                   view.alpha = 0;
                   view.transform = CGAffineTransformMakeTranslation(view.frame.size.width, 0);
//                   contentView.transform = CGAffineTransformIdentity;
               } completion:^(BOOL finished) {
                   [wkself removeView:view];
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
                
                view.layer.shouldRasterize = YES;
                [UIView animateWithDuration:BAlertViewAnimateDuration animations:^{
                    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                } completion:^(BOOL finished){
                    [UIView animateWithDuration:BAlertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        view.alpha = 0;
                        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                    } completion:^(BOOL finished2){
                        [wkself removeView:view];
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




- (void)hideAll{
    
//    while (_showViewArray.count>0) {
//        <#statements#>
//    }
    for (UIView *itemView in _showViewArray) {
        [self hideView:itemView animated:YES completionBlock:nil];
    }
    
    
//    for (int i = 0; i<_showViewArray.count; i++) {
//        [self hide];
//    }

}

//MARK: -  clean

-(void)removeView:(UIView *)view{
    
    
    [view removeFromSuperview];
    [_showViewArray removeObject:view];
    
    
    if (_showViewArray.count < 1) {
         [self clean];
    }
    
}

- (void)clean{
    
    __weak typeof(self) wkself = self;
   
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    wkself.viewController = nil;
    [wkself.window removeFromSuperview];
    wkself.window = nil;
    
    //还原为默认
    self.backgroundColor = BAlertViewBackGroundColor;
    self.shouldTapOutSideClosed = BAlertViewShouldTapOutsideClosed;
    
    
}

//MARK: -  private


-(void)setBackgroundColor:(UIColor *)backgroundColor{

    if (_backgroundColor !=backgroundColor) {
        _backgroundColor = backgroundColor;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 viewController.backgroundColor = _backgroundColor?_backgroundColor:BAlertViewBackGroundColor;
        self.viewController.backgroundColor = backgroundColor;

    }
    
  
}

-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
    if(_shouldTapOutSideClosed != shouldTapOutSideClosed){
        _shouldTapOutSideClosed = shouldTapOutSideClosed;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面
        self.viewController.shouldTapOutSideClosed = shouldTapOutSideClosed;
    }

}
@end
