//
//  BAletToastManager.m
//  BAlertviewDemo
//
//  Created by edz on 2020/1/7.
//  Copyright © 2020 bai.xianzhi. All rights reserved.
//

#import "BAlertToastManager.h"

//==============tostlable================

@implementation BToastLable

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {2, 5, 2, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end


@interface BAlertToastManager()

@end




@implementation BAlertToastManager


+ (instancetype)manager{
    return  [[self alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [BAlertToastConfig defaultConfig];
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
    
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
   
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self makeToast:message disPlayStyle:style showTime:showTime];
        });
        return;
    }
    

    BToastLable *toastView = [[BToastLable alloc] init];
    toastView.backgroundColor = self.config.toastBackGrondColor;
    toastView.textColor = self.config.toastTextColor;
    toastView.font = self.config.tostFont;
    toastView.layer.masksToBounds = YES;
    toastView.layer.cornerRadius = self.config.tostCornerRadius;
    toastView.textAlignment = NSTextAlignmentCenter;
    toastView.alpha = 0;
    toastView.numberOfLines = 0;
    toastView.lineBreakMode = NSLineBreakByCharWrapping;
    [[UIApplication sharedApplication].keyWindow addSubview:toastView];
    
   
    
    CGFloat width = [self stringText:message font:self.config.tostFont isHeightFixed:YES fixedValue:30]+10;
    CGFloat height = 30;
    if (width > [UIScreen mainScreen].bounds.size.width- 20) {
        width = [UIScreen mainScreen].bounds.size.width - 20;
        height = [self stringText:message font:self.config.tostFont isHeightFixed:NO fixedValue:width]+4;
    }
    

    CGRect frame ;
    if (style == BAlertModalToastTop) {
        frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2,[UIScreen mainScreen].bounds.size.height*0.15, width, height);
    }else if (style == BAlertModalToastCenter){
        frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2,([UIScreen mainScreen].bounds.size.height-height)/2, width, height);
    }else{
        frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2,[UIScreen mainScreen].bounds.size.height*0.90-height, width, height);
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
-(CGFloat)stringText:(NSString *)text font:(UIFont *)font isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue
{
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize;
    //返回计算出的size
    resultSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    
    if (isHeightFixed) {
        return resultSize.width;
    } else {
        return resultSize.height;
    }
}



@end
