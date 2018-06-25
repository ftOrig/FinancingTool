//
//  FCommonCounterViewController.h
//  ftool
//
//  Created by apple on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FBaseViewController.h"
#import "AJContainTableController.h"

@interface FCommonCounterViewController : AJContainTableController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *tf_amount;
@property (weak, nonatomic) IBOutlet UITextField *tf_rate;
@property (weak, nonatomic) IBOutlet UITextField *tf_discount; //折扣
@property (weak, nonatomic) IBOutlet UITextField *tf_limit; //年限


- (IBAction)repayTypeChange:(UISegmentedControl *)sender;
- (IBAction)btnCounting:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel *lb_firstRepay;  //等额本金 有
@property (weak, nonatomic) IBOutlet UILabel *lb_dicreaseAmount; //等额本金 有

@property (weak, nonatomic) IBOutlet UILabel *lb_apieceRepay; //等额本息 有

@property (weak, nonatomic) IBOutlet UILabel *lb_allRepayInterest; //共有
@property (weak, nonatomic) IBOutlet UILabel *lb_allRepayAmount; //共有


@end
