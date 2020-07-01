//
//  ViewController.m
//  BAlertviewDemo
//
//  Created by bai on 16/5/11.
//  Copyright © 2016年 bai.xianzhi. All rights reserved.
//

#import "ViewController.h"
#import "BAlertModal.h"
#import "UIView+BAlertModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSArray *toastDataArray;
@property (nonatomic,strong) NSArray *alertViewDataArray;

@property (nonatomic,strong) NSMutableArray *viewArray;

@property (nonatomic,strong) UIView *globleView;
//
//@property (nonatomic,strong) UILabel *secendView;

@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
     _toastDataArray = @[@"吐司",@"长吐司",@"位置吐司"];
    
    
    
     _alertViewDataArray = @[@"位置根据传入的view frame决定",@"默认中间 宽高自定",@"底部 view宽度高度自定 window不缩小",@"底部 window 缩小",@"从左侧移动过来",@"从左侧移动过来 keyWindow跟随移动",@"从右侧移动过来",@"从右侧移动过来 keyWindow跟随移动",@"下拉样式显示",@"自定义 尚需完善",@"点击外部不可回收",@"背景改变问题",@"键盘冲突测试， 点击外部先隐藏键盘",@"多个弹窗同时出现",@"二次弹窗",@"状态栏隐藏",@"状态栏样式改变",@"显示隐藏完毕后执行block",@"点击外部隐藏完毕后执行block",@"view状态"];
    self.mTableView.hidden = NO;
    
    
    
    _viewArray = [NSMutableArray new];
    
   
    [_alertViewDataArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1] ;
        view.frame = CGRectMake(100, 100, 200, 200);
        [_viewArray addObject:view];
        
        if (idx == 10) {
            //点击外部不可回收，为view添加手势回收。根据实际情况可添加按钮等关闭
            //隐藏所有view。
            UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAll)];
            [view addGestureRecognizer:tap2];
            
        }
        if (idx == 12) {
            //键盘冲突测试， 点击外部先隐藏键盘
            UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 50, 200, 50)];
            tf.placeholder = @"键盘测试";
            tf.layer.borderColor = [UIColor greenColor].CGColor;
            tf.layer.borderWidth = 1;
            [view addSubview:tf];
        }
        
        if (idx == 14) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 200, 50)];
            btn.backgroundColor = [UIColor blueColor];
            [btn setTitle:@"点击显示第二个弹窗" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(secondShow) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        
        
        __weak typeof(view) wkview = view;
        if (idx == 19) {
            view.b_showCompletionBlock = ^{
                NSLog(@"view 状态： %ld",(long)(wkview.b_alertViewState));
            };
            view.b_hideCompletionBlock  = ^{
                NSLog(@"view 状态： %ld",(long)(wkview.b_alertViewState));
            };
        }
        
        
        
    }];
    
    
  
    
}

- (UIView *)globleView{
    if (!_globleView) {
        _globleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _globleView.backgroundColor = [UIColor whiteColor];
    }
    return _globleView;
}

//-(UILabel *)firstView{
//    if (!_firstView) {
//        _firstView = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
//        _firstView.userInteractionEnabled = YES;
////        _firstView.text = @"000000";
//        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondShow)];
//        [_firstView addGestureRecognizer:tap];
//        [_firstView setBackgroundColor:[UIColor yellowColor]];
//
//
//    }
//    return _firstView;
//}
//
//-(UILabel *)secendView{
//    if (!_secendView) {
//
//        _secendView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
//        _secendView.userInteractionEnabled = YES;
//
//        //隐藏所有view。
//        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAll)];
//        [_secendView addGestureRecognizer:tap2];
//
//        //隐藏完毕后执行block
//        _secendView.b_tapOutsideHideCompletionBlock = ^{
//            NSLog(@"点击外部隐藏block");
//        };
//
//        //键盘弹出时点击外部会先收键盘
//        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
//        tf.layer.borderColor = UIColor.greenColor.CGColor;
//        tf.layer.borderWidth = 1;
//        [_secendView addSubview:tf];
//        _secendView.backgroundColor = [UIColor purpleColor];
//    }
//    return _secendView;
//}
//

-(UITableView *)mTableView{
    
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _mTableView.separatorColor = [UIColor clearColor];
        _mTableView.backgroundColor = [UIColor clearColor];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.tableFooterView = [UIView new];
        _mTableView.rowHeight  = UITableViewAutomaticDimension;
        _mTableView.estimatedRowHeight = 44;
        _mTableView.showsHorizontalScrollIndicator  = NO;
        _mTableView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_mTableView];
        
        
        
        
    }
    
    return _mTableView;
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?self.toastDataArray.count:self.alertViewDataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        // 吐司测试
        switch (indexPath.row) {
            case 0:
            {
              //普通用法
    
                 [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！"];
                
                //宏定义用法
//                BMAKECENTERTOAST(@"DAFDFASDFASDFA");
              break;
            }
            case 1:
            {
              //长吐司
   
                 [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！" disPlayStyle:BAlertModalToastCenter showTime:BAlertModalToastLong];
    
              break;
            }
            case 2:
            {
              //位置
    
                 [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！" disPlayStyle:BAlertModalToastTop showTime:BAlertModalToastshort];
              break;
            }
        }
    
    }else if (indexPath.section == 1){
        
        switch (indexPath.row) {
            
            case 0:{
                //BAlertModalViewNone,// 位置根据传入的view frame决定
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewNone];
                
                break;
            }
            case 1:{
                //BAlertModalViewCenter,//默认中间 宽高自定
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewCenter];
    
                break;
            }
             
            case 2:{
               // BAlertModalViewBottom ,//底部 view宽度高度自定 window不缩小
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewBottom];
    
               break;
           
            }
               
           
            case 3:{
                //BAlertModalViewBottom2,//底部 window 缩小
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewBottom2];

               break;
           
            }
           
            case 4:{
                 //BAlertModalViewLeftMove,//从左侧移动过来
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewLeftMove];
    
               
               break;
            }
                   
            case 5:{
                
                //BAlertModalViewLeftMove2,//从左侧移动过来 keyWindow跟随移动
                
                
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewLeftMove2];
                
 
                break;
            }
            case 6:{
                //BAlertModalViewRightMove,//从右侧移动过来
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewRightMove];
                break;
            }
            case 7:{
               // BAlertModalViewRightMove2,//从右侧移动过来 keyWindow跟随移动
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewRightMove2];
                break;
            }
            case 8:{
               // BAlertModalViewDropList, //下拉样式显示
                //实际使用时 可计算sender位置 模仿下来选择框
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] disPlayStyle:BAlertModalViewDropList];
                break;
            }
            case 9:{
               // BAlertViewAnimateCustom // 自定义 尚需完善
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] showAnimationBlock:^(UIView *view) {
                     
                     CGRect rect = view.frame;
                     rect.origin.y = 0;
                     [UIView  animateWithDuration:1 animations:^{
                         view.frame = rect;
                     } completion:^(BOOL finished) {
                         
                     }];
                 } hideAnimationBlock:^(UIView *view) {
                    
                     CGRect rect = view.frame;
                      rect.origin.x = 0;
                      [UIView  animateWithDuration:1 animations:^{
                          view.frame = rect;
                      } completion:^(BOOL finished) {
                          
                      }];
                     
                     //返回动画时间 告诉BAlerModel 动画执行完毕可以进行清理工作。
                     return 3.0;
                 }];
                break;
            }
            case 10:{
                
//                @"点击外部不可回收",@"背景改变问题",@"键盘冲突测试",@"多个弹窗同时出现",@"二次弹窗",@"状态栏问题"];
               // 点击外部不可回收
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row] ];
                
                // 必须放在后面show后面 否则无效
                [[BAlertModal sharedInstance]setShouldTapOutSideClosed:NO];
                
                break;
            }
            case 11:{
               // 背景改变问题
                
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                //局部设置 必须放在后面show后面 否则无效
                [BAlertModal sharedInstance].backgroundColor = [UIColor greenColor];
//                [BAlertModal sharedInstance].viewManager.backgroundColor = [UIColor greenColor];
                          
                //全局设置， 设置后都改变
//                [BAlertModal  sharedInstance].viewManager.config.alertViewBackGroundColor = [UIColor greenColor];
                break;
            }
            case 12:{
               // "键盘冲突测试
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                break;
            }
            case 13:{
               // 多个弹窗同时出现
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row -1] disPlayStyle:BAlertModalViewBottom];
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row-2]disPlayStyle:BAlertModalViewLeftMove];
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row-3]disPlayStyle:BAlertModalViewRightMove];
                break;
            }
            case 14:{
               // 二次弹窗
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                
                
                break;
            }
            case 15:{
               //隐藏状态栏
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                
                
                [BAlertModal sharedInstance].alertViewPrefersStatusBarHidden = YES;

               
                
                break;
            }
            case 16:{
               // 状态栏样式改变
                [[BAlertModal sharedInstance]showAlerView:self.viewArray[indexPath.row]];
                
                
                [BAlertModal sharedInstance].aletViewPreferredStatusBarStyle = UIStatusBarStyleLightContent;
                
                break;
            }
            case 17:{
               //  点击外部隐藏完毕后执行block
                UIView *view = self.viewArray[indexPath.row];
                view.b_showCompletionBlock = ^{
                    NSLog(@"显示啦");
                };
                view.b_hideCompletionBlock = ^{
                    NSLog(@"隐藏啦");
                };
                
                [[BAlertModal sharedInstance]showAlerView:view];
                
                
                
                
                break;
            }
           case 18:{
              //  点击外部隐藏完毕后执行block
               UIView *view = self.viewArray[indexPath.row];
               view.b_tapOutsideHideCompletionBlock = ^{
                   NSLog(@"点击外部隐藏啦");
               } ;
               [[BAlertModal sharedInstance]showAlerView:view];
               
               
               
               
               break;
           }
            case 19:{
               //
               
                
                UIView *view = self.viewArray[indexPath.row];
                
                NSLog(@"view state: %ld",(long)(view.b_alertViewState));
                [[BAlertModal sharedInstance]showAlerView:view];
                
               
               
                
                
                
                
                break;
            }
                     
                
            default:
                break;
        }
    }
    

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //cell配置
    if (indexPath.section == 0) {
         cell.textLabel.text = self.toastDataArray[indexPath.row];
    }else if (indexPath.section == 1) {
         cell.textLabel.text = self.alertViewDataArray[indexPath.row];
    }
  
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    lable.backgroundColor = [UIColor grayColor];
    lable.text = section == 0?@"吐司":@"弹窗";
    return lable;
}



-(void)secondShow{

    [[BAlertModal sharedInstance]showAlerView:self.viewArray[0] disPlayStyle:BAlertModalViewBottom animated:YES];
//    [BAlertModal sharedInstance].shouldTapOutSideClosed = NO;
}

-(void)hideAll{
    [[BAlertModal sharedInstance] hideAll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
