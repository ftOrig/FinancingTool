//
//  FCommonCounterViewController.m
//  ftool
//  普通贷款计算器
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FCommonCounterViewController.h"
#import "BaseContentCell.h"

@interface FCommonCounterViewController (){
    CGRect headRect;
    NSInteger repayType;
    
    NSArray *_titleArray;
    NSArray *_contentArray;
}

@end

@implementation FCommonCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NavBar *bar = [[NavBar alloc] initWithTitle:@"普通计算器" leftName:nil rightName:@"" delegate:self];
    
    headRect = self.headView.frame;
    
    [_tableView registerClass:[BaseContentCell class] forCellReuseIdentifier:@"RateViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tf_amount setText:@"1"]; //贷款
    [_tf_discount setText:@"1.0"]; //默认没折扣
    [_tf_rate setText:@"5"]; //利率
    [_tf_limit setText:@"1"]; //年限
    
    repayType = 0;
    
    _titleArray = [[NSArray alloc] initWithObjects:@"活期",@"3个月定期",@"6个月定期",
                   @"1年定期",@"2年定期",@"3年定期",@"5年定期", nil];
    _contentArray = [[NSArray alloc] initWithObjects:@"0.35+浮动", @"1.10+浮动",@"1.30+浮动",@"1.50+浮动",@"2.10+浮动",@"2.75+浮动",@"3.00+浮动",nil];
    
     [_tableView reloadData];
}


- (IBAction)repayTypeChange:(UISegmentedControl *)sender {
    repayType = sender.selectedSegmentIndex;
    
    if (sender.selectedSegmentIndex == 0) {
        [self resetHead:-80];
        
    }else {
        [self resetHead:80];

    }
}

- (IBAction)btnCounting:(UIButton *)sender {
    if ([self isInputed:_tf_amount andPromit:@"请输入金额"] && [self isInputed:_tf_rate andPromit:@"请输入利率"]
        && [self isInputed:_tf_limit andPromit:@"请输入年限"]) {
        if (repayType == 0) { //等额本息
            //每月还款 = [金额*月利率*（1+月利率)^还款月数] / [(1+月利率) ^ 还款月数-1] ;
            double llll = powl(2, 4);
            NSLog(@"pow = %f", llll);
      
            double amount = [_tf_amount.text doubleValue] * 10000;
            double monthRate = [_tf_rate.text doubleValue]/100/12;   //月利率
            long repayMonths = [_tf_limit.text integerValue] * 12; //还款月数
//            amount = 10000; 示例 https://wenku.baidu.com/view/12c20baa680203d8ce2f244d.html?from=search
//            monthRate = 0.005541667;
//            repayMonths = 120;
            double apiecePay = (amount * monthRate * powl((1+monthRate), repayMonths))
                                / ( powl((1+monthRate), repayMonths) -1);
            
            [_lb_apieceRepay setText:[NSString stringWithFormat:@"%.2f", apiecePay]];
            
            double alwayRepay = 0;
            double benjin = (amount/repayMonths) + (amount - alwayRepay) * monthRate;
            [_lb_firstRepay setText:[NSString stringWithFormat:@"%.2f", benjin]];
            
        }else {     //等额本金
            
            
        }
    }
}

-(BOOL) isInputed:(UITextField *)field andPromit:(NSString*)msg{
    if ([field.text isEmpty]) {
        [SVProgressHUD showImage:nil status:msg];
        return NO;
    }else {
        return YES;
    }
}

//显示多少组
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 4;
//}

//每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}


//每一组的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RateViewCell"];
    cell.titLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.conLabel.text = [_contentArray objectAtIndex:indexPath.row];
    cell.lineLabel.hidden = YES;
    
    return cell;
}

-(void) resetHead: (NSInteger) varHight{
    CGRect newFrame = _headView.frame;
    newFrame.size.height = newFrame.size.height + varHight;
    _headView.frame = newFrame;
    
//    [self.tableView setTableHeaderView:_headView];
    //加个动画
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:_headView];
    [self.tableView endUpdates];
    //        headRect.size.height += 80;
    //        self.headView.frame = headRect; 这样改不了
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
