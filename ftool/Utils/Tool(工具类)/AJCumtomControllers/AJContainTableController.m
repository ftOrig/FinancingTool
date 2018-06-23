//
//  AJContainTableController.m
//  SP2P
//
//  Created by Ajax on 16/2/24.
//  Copyright © 2016年 EIMS. All rights reserved.
//

#import "AJContainTableController.h"
#import "MJRefresh.h"
//#import "NoRecordView.h"

@interface AJContainTableController ()
@end

@implementation AJContainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currPage = 1;
    self.totalPage = 100;

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
//#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}



@end

@implementation AJContainTableController(RefreshHeaderFooter)

static char currPageKey;// 属性关联
- (void)setCurrPage:(int)currPage
{
    // 将某个值与某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &currPageKey, @(currPage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)currPage
{
    return [objc_getAssociatedObject(self, &currPageKey) intValue];;
}

static char totalPageKey;// 属性关联
- (void)setTotalPage:(int)totalPage
{
    // 将某个值与某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &totalPageKey, @(totalPage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)totalPage
{
    return [objc_getAssociatedObject(self, &totalPageKey) intValue];
}

static char dataArrayKey;// 属性关联
- (void)setDataArray:(NSMutableArray *)dataArray
{
    // 将某个值与某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &dataArrayKey, dataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dataArray
{
    NSMutableArray *dataArr = objc_getAssociatedObject(self, &dataArrayKey);
    if (!dataArr) {
        dataArr = [NSMutableArray array];
        self.dataArray = dataArr;
    }
    return dataArr;
}

static char tableViewKey;// 属性关联
- (void)setTableView:(UITableView *)tableView
{
    // 将某个值与某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &tableViewKey, tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITableView *)tableView
{
    return objc_getAssociatedObject(self, &tableViewKey);
}

- (void)hideRefreshHeaderFooter
{
    [MyTools hidenNetworkActitvityIndicator];
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)addTableViewRefreshHeader
{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //        [self.tableView.mj_footer setValue:@YES forKeyPath:@"stateLabel.hidden"];
        [(MJRefreshAutoNormalFooter*)weakSelf.tableView.mj_footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
        [MyTools showNetworkActivityIndicator];
        weakSelf.currPage = 1;
        [weakSelf requestData];
        
    }];
}

- (void)addTableViewRefreshHeaderFooter
{
    [self addTableViewRefreshHeader];
    
    __weak typeof(self) weakSelf = self;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currPage ++;
        
        if ( weakSelf.currPage <= weakSelf.totalPage) {
            
            //            [(MJRefreshAutoNormalFooter*)weakSelf.tableView.mj_footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            [weakSelf requestData];
            [MyTools showNetworkActivityIndicator];
        }else{
            
            [(MJRefreshAutoNormalFooter*)weakSelf.tableView.mj_footer setTitle:@"已经到底啦" forState:MJRefreshStateIdle];
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
    footer.automaticallyHidden = YES;
//    footer.stateLabel.hidden = YES;
    self.tableView.mj_footer = footer;
    
}

/** 显示暂无记录视图 */
- (void)hideNoRecordView
{
//    NoRecordView *view = [self.tableView viewWithTag:1000999];
//    [view removeFromSuperview];
}

- (void)showNoRecordView
{
//    CGRect frame = RECT(0, 0, self.tableView.width, 250*AJScaleMiltiplier);
//    NoRecordView *view = [NoRecordView viewWithFrame:frame backgroundColor:nil superview:self.tableView];
//    view.tag = 1000999;
}
@end
