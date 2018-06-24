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
    
    self.dataArray = AppDelegateInstance.aFAccountCategaries.expensesTypeArr;
}

- (void)initView {
    
    NavBar *bar = [[NavBar alloc] initWithTitle:@"编辑分类" leftName:nil rightName:nil delegate:self];
    
    self.tableView = [UITableView tableViewWithFrmae:RECT(0, bar.maxY, MSWIDTH, MSHIGHT-bar.maxY) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleNone superview:self.view];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FEditFirstTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    FFirstType *bean = self.dataArray[indexPath.row];
    cell.textLabel.text = bean.name;
    cell.imageView.image = [UIImage imageNamed:bean.iconName];
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
