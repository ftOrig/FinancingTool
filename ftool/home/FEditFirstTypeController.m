//
//  FEditFirstTypeController.m
//  ftool
//
//  Created by zhouli on 2018/6/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FEditFirstTypeController.h"
#import "FEditFirstTypeCell.h"
#import "FEditSubTypeController.h"

@interface FEditFirstTypeController ()

@end
static NSString * const reuseIdentifier = @"FEditFirstTypeCell";
@implementation FEditFirstTypeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    self.dataArray = AppDelegateInstance.aFAccountCategaries.expensesTypeArr;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.dataArray = AppDelegateInstance.aFAccountCategaries.expensesTypeArr;
    [self.tableView reloadData];
}

- (void)initView {
    
    NavBar *bar = [[NavBar alloc] initWithTitle:@"编辑分类" leftName:nil rightName:@"保存" delegate:self];

    self.tableView = [UITableView tableViewWithFrmae:RECT(0, bar.maxY, MSWIDTH, MSHIGHT-bar.maxY) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLineEtched superview:self.view];
    
    self.tableView.rowHeight = 55.f;
     [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    UIView *footer = [UIView viewWithFrame:RECT(0, 0, MSWIDTH, 50) backgroundColor:nil superview:nil];
    UIButton *btn = [UIButton buttonWithFrame:RECT(50, 30, MSWIDTH-100, 37) backgroundColor:AJWhiteColor title:@"添加分类" titleColor:[UIColor ys_black] titleFont:15 target:self action:@selector(addFirstType:) superview:footer];
    [btn setImage:[UIImage imageNamed:@"FirstType_add"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = EDGEINSET(7, 0, 7, -10);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tableView.tableFooterView = footer;
}

- (void)nextItemClick{
    
    ShowLightMessage(@"已成功保存");
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
    
    FFirstType *bean = self.dataArray[indexPath.row];
    cell.textL.text = bean.name;
    cell.imgV.image = [UIImage imageNamed:bean.iconName];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FFirstType *bean = self.dataArray[indexPath.row];
    FEditSubTypeController *controller = [FEditSubTypeController new];
    controller.title = bean.name;
    controller.selectFirstTypeIndex = indexPath.row;
    [self.navigationController pushViewController:controller animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 9) {
        return NO;
    }
    return YES;
}

@end
