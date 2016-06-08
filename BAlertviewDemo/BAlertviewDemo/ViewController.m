//
//  ViewController.m
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "ViewController.h"
#import "BAlertModal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *buttom  = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [buttom setBackgroundColor:[UIColor greenColor]];
    [buttom setTitle:@"toast" forState:UIControlStateNormal];
    [buttom addTarget:self action:@selector(showToast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom];
    
    
    UIButton *buttom2  = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 30)];
    [buttom2 setBackgroundColor:[UIColor greenColor]];
    [buttom2 setTitle:@"cennterView" forState:UIControlStateNormal];
    buttom2.tag = 1;
    [buttom2 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom2];
    
    
    UIButton *buttom3  = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    [buttom3 setBackgroundColor:[UIColor greenColor]];
    [buttom3 setTitle:@"BottomView" forState:UIControlStateNormal];
    buttom3.tag = 2;
    [buttom3 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom3];
    
    UIButton *buttom4  = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 100, 30)];
    [buttom4 setBackgroundColor:[UIColor greenColor]];
    [buttom4 setTitle:@"NoneView" forState:UIControlStateNormal];
    buttom4.tag = 3;
    [buttom4 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom4];
    
    

    
}



//  ============toast用法===========
-(void)showToast{
    
    //普通用法
    [[BAlertModal sharedInstance]makeToast:@"he00000003"];
    
   
    
    //宏定义用法

//    BMAKETOAST(@"fasdlfjsdljfladsjkfas");
//    BMAKECENTERTOAST(@"DAFDFASDFASDFA");
    
}


//  ============view用法===========
-(void)showView:(UIButton *)sender{
    
    
    
    NSString *message =@"lajldjlajdk\neeeheeeee";
    
    
   
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [view setBackgroundColor:[UIColor yellowColor]];

    
    int tag = (int)sender.tag;
    switch (tag) {
        case 1:
        {
            //center
           
            [[BAlertModal sharedInstance]showAlerView:view disPlayStyle:BAlertModalViewCenter];
            // [BAlertModal sharedInstance].shouldTapOutSideClosed = NO;
            break;
        }
        case 2:
        {
            //bottom
           [[BAlertModal sharedInstance]setBackgroundColor:[UIColor brownColor]];
            [[BAlertModal sharedInstance]showAlerView:view disPlayStyle:BAlertModalViewBottom];
            //[[BAlertModal sharedInstance]setBackgroundColor:[UIColor brownColor]];
            break;
        }
        case 3:
        {
            //none
            [[BAlertModal sharedInstance]showAlerView:view disPlayStyle:BAlertModalViewNone];
            break;
        }
            
        default:
            break;
    }
    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
