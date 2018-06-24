//
//  FEditFirstTypeController.m
//  ftool
//
//  Created by zhouli on 2018/6/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FEditFirstTypeController.h"

@interface FEditFirstTypeController ()

@end

@implementation FEditFirstTypeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    
}

- (void)initView {
    
    NavBar *bar = [[NavBar alloc] initWithTitle:@"编辑分类" leftName:nil rightName:nil delegate:self];

    self.tableView = [UITableView tableViewWithFrmae:RECT(0, bar.maxY, MSWIDTH, MSHIGHT-bar.maxY) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleNone superview:self.view];
    self.tableView.tableFooterView = [UIView new];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
@end
