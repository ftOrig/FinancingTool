//
//  MineController.m
//  ftool
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FMineController.h"
#import "FMineCell.h"
#import "FMyIncomeRecordController.h"

@interface FMineController ()
@property (nonatomic, weak) UIView *ratioView;

@property (nonatomic, weak) UILabel *incomeL;
@property (nonatomic, weak) UILabel *expandseL;
@property (nonatomic, weak) UILabel *budgetL;
@end
static NSString * const reuseIdentifier = @"FMineCell";
@implementation FMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    self.dataArray = @[@"收入记录", @"支出记录"].mutableCopy;
}


- (void)monthIncomeClick:(UIButton *)sender
{
    
}
- (void)monthExpandseClick:(UIButton *)sender
{
    
}
- (void)monthBudgetClick:(UIButton *)sender
{
    
}

- (void)initView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [UITableView tableViewWithFrmae:RECT(0, 0, MSWIDTH, MSHIGHT-self.tabBarController.tabBar.height) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleSingleLineEtched superview:self.view];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = self.tableView.rowHeight = 50.f;
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
    
    UIView *heaer = [UIView viewWithFrame:RECT(0, 0, MSWIDTH, 260) backgroundColor:NavgationColor superview:nil];
    UILabel *dateL = [UILabel labelWithFrame:RECT(20, 50, 200, 25) text:@"06/2018" textColor:[UIColor ys_blue] textFont:35 textAligment:NSTextAlignmentLeft superview:heaer];
    dateL.textColor = RGB(162, 119, 63);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"MM/yyyy";
    NSString *dateStr = [dateFormat stringFromDate:[NSDate date]];
    
    dateL.attributedText = [MyTools getAttributedStringWithText:dateStr start:3 end:dateStr.length textColor:RGB(162, 119, 63) textFont:[UIFont systemFontOfSize:20]];
    
    CGFloat tongViewW = 70;
    CGFloat tongViewH = 130;
    UIView *tongView = [UIView viewWithFrame:RECT(MSWIDTH - tongViewW - 15, dateL.maxY+30, tongViewW, tongViewH) backgroundColor:[UIColor blackColor] superview:heaer];
    tongView.alpha = .2f;
    ViewBorderRadius(tongView, 2, 10, [[UIColor blackColor] colorWithAlphaComponent:.32]);
    
    UIView *ratioView = [UIView viewWithFrame:RECT(MSWIDTH - tongViewW - 15 + 2, dateL.maxY+30, tongViewW-4, tongViewH-2) backgroundColor:[UIColor ys_lightOrange] superview:heaer];
    ratioView.y = tongView.y + 50;
    ratioView.height = tongViewH - 50-2;
    
    self.incomeL = [self addRowWithY:tongView.y-10  Title:@"本月收入" touchaction:@selector(monthIncomeClick:) superView:heaer];
    self.expandseL = [self addRowWithY:heaer.subviews.lastObject.maxY  Title:@"本月支出" touchaction:@selector(monthExpandseClick:) superView:heaer];
    self.budgetL = [self addRowWithY:heaer.subviews.lastObject.maxY  Title:@"预算余额" touchaction:@selector(monthBudgetClick:) superView:heaer];

    self.budgetL.text = @"未设置";
    
    UIView *footer = [UIView viewWithFrame:RECT(0, 0, MSWIDTH, 100) backgroundColor:nil superview:nil];
    UIButton *btn = [UIButton buttonWithFrame:RECT(50, 30, MSWIDTH-100, 37) backgroundColor:AJWhiteColor title:@"退出登录" titleColor:[UIColor ys_black] titleFont:15 target:self action:@selector(signOut:) superview:footer];
    self.tableView.tableFooterView = footer;
    self.tableView.tableHeaderView = heaer;
    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (void)requestData{
    [MyTools hidenNetworkActitvityIndicator];
    [self.tableView.mj_header endRefreshing];
}

- (UILabel *)addRowWithY:(CGFloat)y Title:(NSString *)title touchaction:(nonnull SEL)action superView:(UIView *)heaer{
    
    UIControl *view = [UIControl viewWithFrame:RECT(0, y, MSWIDTH-100, 50) backgroundColor:nil superview:heaer];
    [view addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleL = [UILabel labelWithFrame:RECT(15, 0, 80, 50) text:title textColor:[[UIColor whiteColor] colorWithAlphaComponent:.8] textFont:14 textAligment:NSTextAlignmentLeft superview:view];
    
    CGFloat contentLX = titleL.maxX;
    UILabel *contentL = [UILabel labelWithFrame:RECT(contentLX, 0, view.width-contentLX - 15, 50) text:@"￥0.00" textColor:[UIColor whiteColor] textFont:20 textAligment:NSTextAlignmentRight superview:view];
//    UIView *line = [UIView viewWithFrame:RECT(15, contentL.maxY + 5, MSWIDTH-15, .5) backgroundColor:[UIColor ys_grayLine] superview:view];
//    line.tag = 90;
//    contentL.backgroundColor = AJGrayBackgroundColor;
    CGFloat imgVW = 8.f;
    UIImageView *imgV = [UIImageView imageViewWithFrame:RECT(view.width - imgVW - 5, contentL.y, imgVW, contentL.height) imageFile:@"Payments_arrow" superview:view];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    return contentL;
}

- (void)signOut:(UIButton *)sender
{
    ShowLightMessage(@"已退出登录");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FMineCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        FMyIncomeRecordController *controller = [FMyIncomeRecordController new];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        
    }
}


@end
