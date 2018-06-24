//
//  FSaveCounterViewController.m
//  ftool
//  存款计算器
//  Created by apple on 2018/6/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FSaveCounterViewController.h"

@interface FSaveCounterViewController ()

@end

@implementation FSaveCounterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NavBar *bar = [[NavBar alloc] initWithTitle:@"存款计算器" leftName:@"返回" rightName:nil delegate:self];
    
    
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
