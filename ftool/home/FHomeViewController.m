//
//  FHomeViewController.m
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FHomeViewController.h"
#import "HomeHeader.h"
#import "FHomeCell.h"
#import "FTakeRecordFatherController.h"
#import "FRateViewController.h"

@interface FHomeViewController ()

@property (nonatomic, weak) HomeHeader *header;
@end
static NSString * const reuseIdentifier = @"FHomeCell";
@implementation FHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    self.dataArray = @[@"最新利率", @"记一笔"].mutableCopy;
    self.header.imageURLStringsGroup = @[@"https://static.weijinzaixian.com/ad_0603403dc18654ec40c34a63c5eb5dd8.jpg",
                                         @"https://static.weijinzaixian.com/ad_15bf2acdc7a3119e37d3fae7bcdbd10f.jpg",
                                         @"https://static.weijinzaixian.com/ad_261360cfeb807ef46adbf76b69f5c8a2.jpg"];
}

- (void)initView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [UITableView tableViewWithFrmae:RECT(0, 0, MSWIDTH, MSHIGHT-self.tabBarController.tabBar.height) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLineEtched superview:self.view];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.estimatedRowHeight = tableView.rowHeight = 50.f;
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    HomeHeader *header = [[HomeHeader alloc] initWithFixedHeght];
    self.tableView.tableHeaderView = header;
    self.header = header;
    __weak typeof(self) weakSelf = self;
    header.tapImgBlock = ^(id item){ };
    
    [self addTableViewRefreshHeader];
     [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)requestData{
    [MyTools hidenNetworkActitvityIndicator];
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        FTakeRecordFatherController *controller = [[FTakeRecordFatherController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 0) {
//        FRateViewController *controller = [[FRateViewController alloc] init];
//
//        [self.navigationController pushViewController:controller animated:YES];
        
        
        UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Counters" bundle:nil];
        UIViewController *tenderVC = [homeStoryboard instantiateViewControllerWithIdentifier:@"rateController"];
        tenderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tenderVC animated:YES];
    }
}
@end
