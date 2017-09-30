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
    
    UIButton *buttom  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 30)];
    [buttom setBackgroundColor:[UIColor greenColor]];
    [buttom setTitle:@"toast" forState:UIControlStateNormal];
    [buttom addTarget:self action:@selector(showToast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom];
    
    
    UIButton *buttom2  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 150, 200, 30)];
    [buttom2 setBackgroundColor:[UIColor greenColor]];
    [buttom2 setTitle:@"cennterView" forState:UIControlStateNormal];
    buttom2.tag = 1;
    [buttom2 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom2];
    
    
    UIButton *buttom3  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 30)];
    [buttom3 setBackgroundColor:[UIColor greenColor]];
    [buttom3 setTitle:@"BottomView" forState:UIControlStateNormal];
    buttom3.tag = 2;
    [buttom3 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom3];
    
    UIButton *buttom4  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 250, 200, 30)];
    [buttom4 setBackgroundColor:[UIColor greenColor]];
    [buttom4 setTitle:@"NoneView" forState:UIControlStateNormal];
    buttom4.tag = 3;
    [buttom4 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom4];
    
    

    UIButton *buttom5  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 300, 200, 30)];
    [buttom5 setBackgroundColor:[UIColor greenColor]];
    [buttom5 setTitle:@"left" forState:UIControlStateNormal];
    buttom5.tag = 4;
    [buttom5 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom5];
    
    UIButton *buttom6  = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 350, 200, 30)];
    [buttom6 setBackgroundColor:[UIColor greenColor]];
    [buttom6 setTitle:@"dropList" forState:UIControlStateNormal];
    buttom6.tag = 5;
    [buttom6 addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttom6];
    /** 将状态栏文本颜色设置为白色 */
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    /** 将状态栏文本颜色设置为黑色 ,默认就是黑色 */
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
  
    
}




//  ============toast用法===========
-(void)showToast{
    
    //普通用法
    [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！"];
    
  // [[BAlertModal sharedInstance]makeToast:@"he000"];
    
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
//           [[BAlertModal sharedInstance]setBackgroundColor:[UIColor brownColor]];
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
            
        case 4:
        {
            //none
            [[BAlertModal sharedInstance]showAlerView:view disPlayStyle:BAlertModalViewLeftMove];
            
            
           
            break;

        }
        case 5:
        {
            //none
            UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
            CGRect rect=[sender convertRect: sender.bounds toView:window];

            view.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+1, rect.size.width,view.frame.size.height);

            [[BAlertModal sharedInstance]showAlerView:view disPlayStyle:BAlertModalViewDropList];
           
            
           
            
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
