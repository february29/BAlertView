//
//  BAlertViewManager.m
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import "BAlertViewManager.h"
#import "UIView+BAlertModel.h"

//==============view viewController================

@interface BAlerterViewController()

@property (nonatomic,assign) BOOL iskeyBoardShow;

@end


@implementation BAlerterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
     _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_backBtn addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setBackgroundColor:self.backgroundColor];
    [self.view addSubview:_backBtn];
}
//ios8 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return self.alertViewPrefersStatusBarHidden; // 返回NO表示要显示，返回YES将hiden
}
- (UIStatusBarStyle)preferredStatusBarStyle{
   
    return self.aletViewPreferredStatusBarStyle;;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    if(_backgroundColor != backgroundColor){
        _backgroundColor = backgroundColor;
        [_backBtn setBackgroundColor:backgroundColor];
    }
    
}

-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
    
    _shouldTapOutSideClosed = shouldTapOutSideClosed;
    _backBtn.userInteractionEnabled = shouldTapOutSideClosed;
    
}

-(void)setAletViewPreferredStatusBarStyle:(UIStatusBarStyle)aletViewPreferredStatusBarStyle{
    _aletViewPreferredStatusBarStyle = aletViewPreferredStatusBarStyle;
}
-(void)setAlertViewPrefersStatusBarHidden:(BOOL)alertViewPrefersStatusBarHidden{
    _alertViewPrefersStatusBarHidden = alertViewPrefersStatusBarHidden;
}

//取消编辑状态，alertView中带输入框时 如果设置shouldTapOutSideClosed 为no时可回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    self.iskeyBoardShow = YES;
}
-(void)keyboardWillHide:(NSNotification *)notification{
     self.iskeyBoardShow = NO;
}

-(void)dimiss{
    if (self.iskeyBoardShow) {
        [self.view endEditing:YES];
    }else{
        UIView *hideView = [self.manager.showViewArray lastObject];
        [self.manager hideWithCompletionBlock:hideView.b_tapOutsideHideCompletionBlock];
    }
        
   
}
@end

@interface BAlertViewManager()

/// 用于显示alertview的window。
@property (nonatomic,strong) UIWindow *window;
/// window上的vc
@property (nonatomic,strong) BAlerterViewController *viewController;
/// 原来应用的view
@property (nonatomic,strong) UIWindow *delegateWindow;
/// 最后显示view
@property (nonatomic,strong) UIView *contentView;


@end


@implementation BAlertViewManager


+ (instancetype)manager{
    return  [[self alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouldTapOutSideClosed = YES;
        _showViewArray = [NSMutableArray new];
        _delegateWindow =  [[[UIApplication sharedApplication] delegate] window];
        
        self.config = [BAlertViewConfig defaultConfig];
    }
    return self;
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
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _window.opaque = NO;
        
        
    }
    
    if (!_viewController) {
        _viewController = [[BAlerterViewController alloc] init];
       
        _viewController.manager = self;
    
        _viewController.backgroundColor = self.config.alertViewBackGroundColor;
        _viewController.shouldTapOutSideClosed = self.config.alertViewShouldTapOutsideClosed;
        _viewController.aletViewPreferredStatusBarStyle = self.config.alertViewPreferredStatusBarStyle;
        _viewController.alertViewPrefersStatusBarHidden = self.config.alertViewPrefersStatusBarHidden;
        
        
    }
    
     __weak typeof(self) wkself = self;
    
    _window.rootViewController = _viewController;
    _contentView = view;
    [_viewController.view addSubview:_contentView];
    
    //_showViewInfoArray  有内容证明 已经显示了 此时为二次弹窗 不需要动画
    if (animated && _showViewArray.count == 0 ) {
        wkself.viewController.backBtn.alpha = 0;
        [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
           wkself.viewController.backBtn.alpha = 1;
        }];
    }
       
    
    view.b_showStyle = style;
    view.b_hideStyle = style;
    view.b_showCompletionBlock = completion;
    [_showViewArray addObject:view];
    
    
    if (style == BAlertModalViewCenter) {
        _contentView.center = _viewController.view.center;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [wkself.window makeKeyAndVisible];
        if(animated){
            [wkself viewShowAnimateWithAnimateType:style completionBlock:completion];
        }else{
            if (completion) {
                completion();
            }
        }
    });
    
   
}


-(void)viewShowAnimateWithAnimateType:(BAlertModalViewDisPlayStyle)animateType completionBlock:(void(^)(void))completion{
    
    
    
    __weak typeof(self) wkself = self;
    switch (animateType) {
        case BAlertModalViewBottom2:
        {
            wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            }];
            //这里没有Break 会执行下面的动画
        }
        case BAlertModalViewBottom:
        {
            
            CGRect newRct =     wkself.contentView.frame ;
//            newRct.size.width = MSCW;
            newRct.origin.x = 0;
            newRct.origin.y = [UIScreen mainScreen].bounds.size.height; //开始的时候在屏幕下方
           
            wkself.contentView.frame = newRct;
    
//            wkself.contentView.layer.shouldRasterize = YES;
            
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                CGRect newRct = wkself.contentView.frame ;
                newRct.origin.y = [UIScreen mainScreen].bounds.size.height-newRct.size.height;
                wkself.contentView.frame = newRct;
                wkself.contentView.alpha = 1.0f;
                
            } completion:^(BOOL finished) {
//                wkself.contentView.layer.shouldRasterize = NO;
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
//            wkself.contentView.layer.shouldRasterize = YES;
            wkself.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
//                wkself.contentView.layer.shouldRasterize = NO;
                if (completion) {
                    completion();
                }
            }];
            
            break;
        }
        case BAlertModalViewDropList:
        {
            
            CGRect viewFram = wkself.contentView.frame;
            
            CGRect startFrame = viewFram;
            startFrame.size.height = 0;
            
            CGRect endFrame = viewFram;
            
            wkself.contentView.frame = startFrame;
            wkself.contentView.alpha = 0.0f;
           
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                
                wkself.contentView.frame = endFrame;
                wkself.contentView.alpha = 1;
            } completion:^(BOOL finished) {
//                wkself.contentView.layer.shouldRasterize = NO;
                if (completion) {
                    completion();
                }
            }];

            
            break;
        }
        case BAlertModalViewLeftMove2:{
            wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, wkself.contentView.frame.size.width, 0);
            }];
        }
        case BAlertModalViewLeftMove:
        {
            wkself.contentView.hidden = NO;
            wkself.contentView.alpha = 0;
            
            
            wkself.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -wkself.contentView.frame.size.width, 0);
            
//            wkself.contentView.layer.shouldRasterize = YES;
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            } completion:^(BOOL finished) {
//                wkself.contentView.layer.shouldRasterize = NO;
                if (completion) {
                    completion();
                }

            }];
            
            
            
            break;
        }
        
        case BAlertModalViewRightMove2:{
            wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
               wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -wkself.contentView.frame.size.width, 0);
            }];
        }
        case BAlertModalViewRightMove:
        {
            wkself.contentView.hidden = NO;
            wkself.contentView.alpha = 0;
            
            wkself.contentView.transform = CGAffineTransformMakeTranslation(wkself.contentView.frame.size.width, 0);
            
//            wkself.contentView.layer.shouldRasterize = YES;
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                wkself.contentView.alpha = 1;
                wkself.contentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
//                wkself.contentView.layer.shouldRasterize = NO;
                
                if (completion) {
                    completion();
                }

            }];
            
            
            
            break;
        }
        case BAlertViewAnimateCustom:{
            if (wkself.contentView.b_showBlock) {
                wkself.contentView.b_showBlock(wkself.contentView);
            }
            
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

- (void)hideAnimated:(BOOL)animated completionBlock:(void(^)(void))completion{
    [self hideView:[_showViewArray lastObject] animated:animated completionBlock:completion];
}


-(void)hideView:(UIView *)view hideAnimationBlock:(BAlertModelHideAnimationBlock)hideAnimationBlock{
    view.b_hideBlock = hideAnimationBlock;
    [self hideView:view animated:YES completionBlock:nil];
}

- (void)hideView:(UIView *)view animated:(BOOL)animated  completionBlock:(void(^)(void))completion{
    
    __weak typeof(self) wkself = self;
    
    if(!animated){
//         wkself.viewController.backBtn.alpha = 0;
        [wkself removeView:view];;
        if(completion){
            completion();
        }
        return;
    }
    
   
    
 
    BAlertModalViewDisPlayStyle style = view.b_hideStyle;
    view.b_hideCompletionBlock = completion;
    
  
    //动画隐藏时间 自定义模式时动画隐藏不一定为默认值
    __block NSTimeInterval hideDuration = self.config.alertViewAnimateDuration;
    
    switch (style) {
            
        case BAlertModalViewBottom2 :
        {
            
           
            wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                wkself.delegateWindow.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            }];

        }
        case BAlertModalViewBottom :
        {

//            view.layer.shouldRasterize = YES;
            [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                CGRect newRct = view.frame ;
                newRct.origin.y = [UIScreen mainScreen].bounds.size.height;
                view.frame = newRct;
                view.alpha = 0.8f;
            } completion:^(BOOL finished) {
//                view.layer.shouldRasterize = NO;
                [wkself removeView:view];
                view.alpha = 1.0f;
                if(completion){
                    completion();
                }
            }];
            
            break;
        }
        case BAlertModalViewDropList:
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                float tableH = wkself.contentView.frame.size.height;
                           

                __block CGRect frame = wkself.contentView.frame;
//                frame.size.height = tableH;
//                wkself.contentView.frame = frame;
                
                wkself.contentView.alpha = 1.0f;
//                view.layer.shouldRasterize = YES;
                
                [UIView animateWithDuration:self.config.alertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    view.alpha = 0;
                   
                    frame.size.height = 0;
                    wkself.contentView.frame = frame;
                    
         
                } completion:^(BOOL finished2){
//                    view.layer.shouldRasterize = NO;
                    [wkself removeView:view];
                    view.alpha = 1;
                    frame.size.height = tableH;
                    wkself.contentView.frame = frame;
                    
                    if(completion){
                        completion();
                    }
                    
                    
                }];
                
            });
            

            break;
        }
        case BAlertModalViewLeftMove2:{
            
             wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, view.frame.size.width, 0);
             [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                 wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
             }];
        }
            
        case BAlertModalViewLeftMove:{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                view.alpha = 1;
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, 0);
                
//                view.layer.shouldRasterize = YES;
     
                [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                    view.alpha = 0;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -view.frame.size.width, 0);
                } completion:^(BOOL finished) {
//                    view.layer.shouldRasterize = NO;
                    [wkself removeView:view];
                    view.alpha = 1;
                    view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, 0);
                    if(completion){
                        completion();
                    }
                    
                }];
                
            });
            
            
            break;
        }
        case BAlertModalViewRightMove2:{
            
             wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -view.frame.size.width, 0);
             [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                 wkself.delegateWindow.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
             }];
        }
      
        case BAlertModalViewRightMove:{
           
           dispatch_async(dispatch_get_main_queue(), ^{
               
               
               view.alpha = 1;
               view.transform = CGAffineTransformIdentity;
//               view.layer.shouldRasterize = YES;
//               contentView.transform = CGAffineTransformMakeTranslation(-contentView.frame.size.width, 0);
    
               [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                   view.alpha = 0;
                   view.transform = CGAffineTransformMakeTranslation(view.frame.size.width, 0);
//                   contentView.transform = CGAffineTransformIdentity;
               } completion:^(BOOL finished) {
//                   view.layer.shouldRasterize = NO;
                   [wkself removeView:view];
                   view.transform = CGAffineTransformIdentity;
                   view.alpha = 1;
                   if(completion){
                       completion();
                   }
                   
               }];
               
           });
           
           
           break;
       
        }
        case BAlertModalViewNone:{
            
            //带完善 ，现背景消失无动画
            [wkself removeView:view];
            if(completion){
                completion();
            }
            
            break;
        }
        case BAlertViewAnimateCustom:{
            if (view.b_hideBlock) {
                hideDuration = view.b_hideBlock(view);
                
               
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(hideDuration * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [wkself removeView:view];
                    //不执行,因为通常情况下 完成回调在定义hideblock时设置。
//                    if(completion){
//                        completion();
//                    }
                });
                
            }else{
                NSLog(@"无隐藏动画");
            }
           
            break;
        }
            
        default:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                view.layer.shouldRasterize = YES;
                [UIView animateWithDuration:self.config.alertViewAnimateDuration animations:^{
                    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                } completion:^(BOOL finished){
                    [UIView animateWithDuration:self.config.alertViewAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        view.alpha = 0;
                        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
                    } completion:^(BOOL finished2){
//                        view.layer.shouldRasterize = NO;
                        [wkself removeView:view];
                        view.alpha = 1;
                        view.transform = CGAffineTransformIdentity;
                        if(completion){
                            completion();
                        }
                        
                    }];
                }];
            });
            
            break;
        }
            
    }
    
    //如果_showViewInfoArray只有1个，证明这是最后一个 背景做动画
      
    if ( animated && _showViewArray.count <= 1 ) {
        wkself.viewController.backBtn.alpha = 1;
        [UIView animateWithDuration:hideDuration animations:^{
            wkself.viewController.backBtn.alpha = 0;
        }];
         
    }
    
}




- (void)hideAll{
    
    for (UIView *itemView in _showViewArray) {
        [self hideView:itemView animated:YES completionBlock:nil];
    }

}



//MARK: -  clean

-(void)removeView:(UIView *)view{
    
    
    [view removeFromSuperview];
    [self cleanView:view];
    [_showViewArray removeObject:view];
    
    
    if (_showViewArray.count < 1) {
         [self cleanAlertModel];
    }
    
}

- (void)cleanAlertModel{
    
    __weak typeof(self) wkself = self;
   
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    wkself.viewController = nil;
    [wkself.window removeFromSuperview];
    wkself.window = nil;
    
    //还原为默认
    self.backgroundColor = self.config.alertViewBackGroundColor;
    self.shouldTapOutSideClosed = self.config.alertViewShouldTapOutsideClosed;
    self.alertViewPrefersStatusBarHidden = self.config.alertViewPrefersStatusBarHidden;
    self.aletViewPreferredStatusBarStyle = self.config.alertViewPreferredStatusBarStyle;
    
    
}

-(void)cleanView:(UIView *)view{
    //待完善。恢复view的初始状态
}

//MARK: -  private


-(void)setBackgroundColor:(UIColor *)backgroundColor{

    if (_backgroundColor !=backgroundColor) {
        _backgroundColor = backgroundColor;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 或者调用show之后再设置次属性
        self.viewController.backgroundColor = backgroundColor;

    }
    
  
}

-(void)setShouldTapOutSideClosed:(BOOL)shouldTapOutSideClosed{
    if(_shouldTapOutSideClosed != shouldTapOutSideClosed){
        _shouldTapOutSideClosed = shouldTapOutSideClosed;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 或者调用show之后再设置次属性
        self.viewController.shouldTapOutSideClosed = shouldTapOutSideClosed;
    }

}



-(void)setAletViewPreferredStatusBarStyle:(UIStatusBarStyle)aletViewPreferredStatusBarStyle{
    if (_aletViewPreferredStatusBarStyle != aletViewPreferredStatusBarStyle ) {
        _aletViewPreferredStatusBarStyle = aletViewPreferredStatusBarStyle;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 或者调用show之后再设置次属性
        self.viewController.aletViewPreferredStatusBarStyle = aletViewPreferredStatusBarStyle;
    }
}

- (void)setAlertViewPrefersStatusBarHidden:(BOOL)alertViewPrefersStatusBarHidden{
    if (_alertViewPrefersStatusBarHidden != alertViewPrefersStatusBarHidden) {
        _alertViewPrefersStatusBarHidden = alertViewPrefersStatusBarHidden;
        // 没有show之前viewController为空这句话不会执行真正的赋值操作在show里面 或者调用show之后再设置次属性
        self.viewController.alertViewPrefersStatusBarHidden = alertViewPrefersStatusBarHidden;
    }
}


@end
