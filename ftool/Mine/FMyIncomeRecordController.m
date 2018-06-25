//
//  FMyIncomeRecordController.m
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FMyIncomeRecordController.h"
#import "FMyIncomeRecordCell.h"
#import "AJMonthSectionHeader.h"

@interface FMyIncomeRecordController ()

@end
static NSString * const reuseIdentifier = @"FMyIncomeRecordCell";
static NSString * const reuseIdentifier2 = @"AJMonthSectionHeader";
@implementation FMyIncomeRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    NavBar *bar = [[NavBar alloc] initWithTitle:@"收入记录" leftName:nil rightName:@"" delegate:self];
    
    self.tableView = [UITableView tableViewWithFrmae:RECT(0, bar.maxY, MSWIDTH, MSHIGHT-bar.maxY) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLineEtched superview:self.view];
    
    self.tableView.rowHeight = 55.f;
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    UIView *footer = [UIView viewWithFrame:RECT(0, 0, MSWIDTH, 100) backgroundColor:nil superview:nil];
    UIButton *btn = [UIButton buttonWithFrame:RECT(50, 30, MSWIDTH-100, 37) backgroundColor:AJWhiteColor title:@"记一笔" titleColor:[UIColor ys_black] titleFont:15 target:self action:@selector(addMoreRecordClick:) superview:footer];
    [btn setImage:[UIImage imageNamed:@"FirstType_add"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = EDGEINSET(7, 0, 7, -10);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.tableFooterView = footer;
    [self.tableView registerClass:[AJMonthSectionHeader class] forHeaderFooterViewReuseIdentifier:reuseIdentifier2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}

- (void)addMoreRecordClick:(UIButton *)sender
{
//    if (self.dataArray.count >= 20) {
//        ShowLightMessage(@"大哥，最多可添加20个子分类, 谢谢！");
//        return;
//    }
//    FAddFirstTypeController *controller = [FAddFirstTypeController new];
//    [self presentViewController:controller animated:YES completion:^{}];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMyIncomeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    FFirstType *bean = self.dataArray[indexPath.row];
//    cell.textL.text = bean.name;
//    cell.imgV.image = [UIImage imageNamed:bean.iconName];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    static NSString *headerReuse = @""
    AJMonthSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier2];
    
//    header.
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    FFirstType *bean = self.dataArray[indexPath.row];
//    FEditSubTypeController *controller = [FEditSubTypeController new];
//    controller.title = bean.name;
//    controller.selectFirstTypeIndex = indexPath.row;
//    [self.navigationController pushViewController:controller animated:YES];
}

@end
