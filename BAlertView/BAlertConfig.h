//
//  BAlertConfig.h
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#ifndef BAlertConfig_h
#define BAlertConfig_h

#define MSCW [UIScreen mainScreen].bounds.size.width
#define MSCH [UIScreen mainScreen].bounds.size.height  //如果带导航条toast 要在这里 [UIScreen mainScreen].bounds.size.height-64
#define BAlertViewAPPStatusBarHidden NO  //如果app中没有任务栏这里设置为YES



//  ============在这里方便配置toast样式相关设置===========

#define BAlertToastFont 14                             //toast的字体大小
#define BAlertToastBackGrond  [UIColor blackColor]     //toast背景颜色
#define BAlertToastTextColor [UIColor whiteColor]      //toast字体颜色

//  =============================================





//  ============在这里方便配置view样式相关设置===========
#define BAlertViewAnimateDuration 0.3                                  //动画时间
#define BAlertViewBackGroundColor [UIColor colorWithWhite:0 alpha:0.3] //view的默认背景颜色
#define BAlertViewShouldTapOutsideClosed YES//view的点击外部关闭

//  =============================================






#endif /* BAlertConfig_h */
