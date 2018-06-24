//
//  FEditSubTypeController.m
//  ftool
//
//  Created by admin on 2018/6/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FEditSubTypeController.h"
#import "FEditFirstTypeCell.h"
static NSString * const reuseIdentifier = @"FEditFirstTypeCell";
@interface FEditSubTypeController ()

@end

@implementation FEditSubTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initView];
    
    FFirstType *firstBena = AppDelegateInstance.aFAccountCategaries.expensesTypeArr[self.selectFirstTypeIndex];
    self.dataArray = firstBena.subTypeArr.copy;
}

- (void)initView {
    
    NavBar *bar = [[NavBar alloc] initWithTitle:self.title?:@"编辑子分类" leftName:nil rightName:@"保存" delegate:self];
    
//    UIView *bugetView = [UIView viewWithFrame:RECT(0, bar.maxY, MSWIDTH, 50) backgroundColor:AJWhiteColor superview:self.view];
//    UITextField
    
    self.tableView = [UITableView tableViewWithFrmae:RECT(0, bar.maxY, MSWIDTH, MSHIGHT-bar.maxY) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLineEtched superview:self.view];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = 55.f;
    UIView *footer = [UIView viewWithFrame:RECT(0, 0, MSWIDTH, 50) backgroundColor:nil superview:nil];
    UIButton *btn = [UIButton buttonWithFrame:RECT(50, 30, MSWIDTH-100, 37) backgroundColor:AJWhiteColor title:@"添加分类" titleColor:[UIColor ys_black] titleFont:15 target:self action:@selector(addFirstType:) superview:footer];
    [btn setImage:[UIImage imageNamed:@"FirstType_add"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = EDGEINSET(7, 0, 7, -10);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.tableFooterView = footer;
}

- (void)nextItemClick{
    
    // 预算
    // 分类修改
    
}

- (void)addFirstType:(UIButton *)sender
{
    //    AJRedSelectListController *controller = [AJRedSelectListController new];
    //    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FEditFirstTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    FSubType *bean = self.dataArray[indexPath.row];
    cell.textL.text = bean.name;
    cell.imgV.image = [UIImage imageNamed:bean.iconName];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 9) {
        return NO;
    }
    return YES;
}

@end
