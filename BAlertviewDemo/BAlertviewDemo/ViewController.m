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
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UILabel *firstView;

@property (nonatomic,strong) UILabel *secendView;

@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _dataArray = @[@"toast",@"cennterView",@"BottomView",@"NoneView",@"left",@"dropList",@"custom",@"",@"",@""];
   
    self.mTableView.hidden = NO;
    
  
    
}

-(UILabel *)firstView{
    if (!_firstView) {
        _firstView = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        _firstView.userInteractionEnabled = YES;
//        _firstView.text = @"000000";
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondShow)];
        [_firstView addGestureRecognizer:tap];
        [_firstView setBackgroundColor:[UIColor yellowColor]];
           
           
    }
    return _firstView;
}

-(UILabel *)secendView{
    if (!_secendView) {

        _secendView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        _secendView.userInteractionEnabled = YES;
        
        //隐藏所有view。
        UITapGestureRecognizer *tap2= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAll)];
        [_secendView addGestureRecognizer:tap2];
        
        //隐藏完毕后执行block
        _secendView.b_tapOutsideHideCompletionBlock = ^{
            NSLog(@"点击外部隐藏block");
        };
        
        //键盘弹出时点击外部会先收键盘
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        tf.layer.borderColor = UIColor.greenColor.CGColor;
        tf.layer.borderWidth = 1;
        [_secendView addSubview:tf];
        _secendView.backgroundColor = [UIColor purpleColor];
    }
    return _secendView;
}


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






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
          //普通用法
//            [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！"];
             [[BAlertModal sharedInstance]makeToast:@"前途是光明的，道路是曲折的。世界和平！！" disPlayStyle:BAlertModalToastBottom showTime:BAlertModalToastLong];
            
          // [[BAlertModal sharedInstance]makeToast:@"he000"];
            
            //宏定义用法

//            BMAKETOAST([NSNull null]);
            BMAKECENTERTOAST(@"DAFDFASDFASDFA");
          break;
        }
        case 1:{
            [[BAlertModal sharedInstance]showAlerView:self.secendView disPlayStyle:BAlertModalViewCenter];
            
            break;
        }
        case 2:{
            //bottom
//           [[BAlertModal sharedInstance]setBackgroundColor:[UIColor brownColor]];
            [[BAlertModal sharedInstance]showAlerView:self.firstView disPlayStyle:BAlertModalViewBottom];
            [[BAlertModal sharedInstance]setBackgroundColor:[UIColor brownColor]];
            break;
        }
         
        case 3:{
        
           [[BAlertModal sharedInstance]showAlerView:self.firstView disPlayStyle:BAlertModalViewNone];
           break;
       
        }
           
       
        case 4:{
           [[BAlertModal sharedInstance]showAlerView:self.firstView disPlayStyle:BAlertModalViewLeftMove];
           break;
       
        }
       
        case 5:{
          
//           UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//
//            CGRect rect=[sender convertRect: sender.bounds toView:window];

//           self.firstView.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height+1, rect.size.width,self.firstView.frame.size.height);

            //实际使用时 可计算sender位置 模仿下来选择框
           [[BAlertModal sharedInstance]showAlerView:self.firstView disPlayStyle:BAlertModalViewDropList];
           break;
        }
               
        case 6:{
            
            [[BAlertModal sharedInstance]showAlerView:self.firstView showAnimationBlock:^(UIView *view) {
                
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
        case 7:{
            break;
        }
        case 8:{
            break;
        }
            
            
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //cell配置
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}



-(void)secondShow{
    
    [[BAlertModal sharedInstance]showAlerView:self.secendView disPlayStyle:BAlertModalViewBottom animated:YES];
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
