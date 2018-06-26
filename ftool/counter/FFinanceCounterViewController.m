//
//  FFinanceCounterViewController.m
//  ftool
//  理财计算器
//  Created by apple on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FFinanceCounterViewController.h"

@interface FFinanceCounterViewController ()

@end

@implementation FFinanceCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavBar *bar = [[NavBar alloc] initWithTitle:@"理财计算器" leftName:nil rightName:@"" delegate:self];
    
    
}

//查看明细
- (IBAction)btn_lookDetail:(UIButton *)sender {
}

- (IBAction)segLimitTypeChange:(UISegmentedControl *)sender {
}

- (IBAction)segRateTypeChange:(UISegmentedControl *)sender {
}

//选择还款类型
- (IBAction)btn_selectRepayWay:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
