//
//  FTakeRecordExpandController.m
//  ftool
//
//  Created by admin on 2018/6/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FTakeRecordExpandController.h"
#import "FTakeRecordExpandView.h"

@interface FTakeRecordExpandController ()

@end

@implementation FTakeRecordExpandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    self.view.backgroundColor = AJGrayBackgroundColor;
    UIScrollView *tableview = [UIScrollView viewWithFrame:CGRectMake(0, 0, MSWIDTH, self.view.height-70) backgroundColor:AJWhiteColor superview:self.view];
//    tableview.tableFooterView = [UIView new];
    tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    FTakeRecordExpandView *contentV = [FTakeRecordExpandView viewWithFrame:RECT(0, 0, MSWIDTH, 500) backgroundColor:nil superview:tableview];
    tableview.contentSize = CGSizeMake(0, contentV.height+30);
    
    CGFloat leading = 15.f;
    CGFloat btnW = (MSWIDTH - 2*leading - 40)/2;
    UIButton *saveBtn = [AJCornerCircle buttonWithFrame:RECT(leading, tableview.maxY+15, btnW, 35) backgroundColor:NavgationColor title:@"保存" titleColor:AJWhiteColor titleFont:15 target:self action:@selector(saveBtnClick:) superview:self.view];
    // 再来
    UIButton *oneMoreBtn = [AJCornerCircle buttonWithFrame:RECT(saveBtn.maxX + 40, saveBtn.y, btnW, 35) backgroundColor:AJWhiteColor title:@"再来一笔" titleColor:NavgationColor titleFont:15 target:self action:@selector(oneMoreBtnClick:) superview:self.view];
    oneMoreBtn.layer.borderColor = NavgationColor.CGColor;
    oneMoreBtn.layer.borderWidth = .7f;
    
    saveBtn.autoresizingMask = oneMoreBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
}

- (void)oneMoreBtnClick:(UIButton *)sender
{
    
}

- (void)saveBtnClick:(UIButton *)sender
{
    
}
@end
