//
//  FHomeViewController.m
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FHomeViewController.h"

@interface FHomeViewController ()

@end

@implementation FHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [UITableView tableViewWithFrmae:RECT(0, 0, MSWIDTH, MSHIGHT-self.tabBarController.tabBar.height) backgroundColor:AJGrayBackgroundColor delegate:self tableViewStyle:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleNone superview:self.view];
    self.tableView = tableView;
    //    tableView.contentInset = EDGEINSET(0, 0, 10, 0);
    //    self.tableView.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//    HomeHeader *header = [[HomeHeader alloc] initWithFixedHeght];
//    self.tableView.tableHeaderView = header;
//    header.hidden = YES;
//    self.header = header;
//    __weak typeof(self) weakSelf = self;
//    header.tapImgBlock = ^(id item){
//        
//        NSString *url = [item valueForKey:@"url"];
//        if (NSNotFound != [url rangeOfString:@"uc/scores"].location) {// 是积分商城的，没有活动网页，直接进入原生积分商城界面
//            if (!AppDelegateInstance.userInfo) {
//                [ReLogin goLogin:weakSelf];
//                return;
//            }
//            IntegralMallController *integraVc = [[IntegralMallController alloc] init];
//            integraVc.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:integraVc animated:YES];
//            return ;
//        }
//        NSString *title = nil;
//        if ([item isKindOfClass:[HomeAds class]]) {// 广告,顶部banner
//            
//            title = [item valueForKey:@"info"];
//            //广告栏单独设置，需要分享
//            HomeAds *homeads=item;
//            [weakSelf pushToWebviewControllerWithsharUrl:homeads];
//        }else{// 公告
//            
//            title = [item valueForKey:@"title"];
//            [weakSelf pushToWebviewControllerWithUrl:url title:title];
//        }
//    };
//    
//    HomeFooter *footer = [[HomeFooter alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 42)];
//    self.tableView.tableFooterView = footer;
//    footer.hidden = YES;
//    self.footer = footer;
//    
//    [self addTableViewRefreshHeader];
//    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier4 bundle:nil] forCellReuseIdentifier:reuseIdentifier4];
//    [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier2 bundle:nil] forCellReuseIdentifier:reuseIdentifier2];
//    [self.tableView registerClass:[NoviceWelfareCell class] forCellReuseIdentifier:reuseIdentifier5];
//    // 网络请求数据失败或空时的视图 双11活动 86：72
//    FLAnimatedImageView *freserImgV = [[FLAnimatedImageView alloc] initWithFrame:RECT(MSWIDTH - 15 -86, self.header.height + 30, 86, 84)];
//    
//    [self.view addSubview:freserImgV];
//    freserImgV.hidden = YES;
//    freserImgV.userInteractionEnabled = YES;
//    self.freserImgV = freserImgV;
//    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"Home_red" withExtension:@"gif"];
//    NSData *data1 = [NSData dataWithContentsOfURL:url1];
//    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//    self.freserImgV.animatedImage = animatedImage1;
//    self.freserImgV.contentMode = UIViewContentModeScaleAspectFit;
//    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFresherGift:)];
//    [self.freserImgV addGestureRecognizer:tapges];
}
@end
