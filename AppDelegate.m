//
//  AppDelegate.m
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "FTabBarController.h"
#import "IQKeyboardManager.h"
#import "NSDate+BRAdd.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AppDefaultUtil sharedInstance] setLoginState:NO]; //测试登录
    NSString *clientVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"clientVersion"];
    //判断应用程序是否更新了版本
    NSLog(@"clientVersion = [%@]", clientVersion);
    if ([clientVersion isEqualToString:CLIENT_VERSION]) {
        NSLog(@"未更新,正常使用");
        
    }else if(clientVersion == nil ){
        NSLog(@"首次安装");
        [[NSUserDefaults standardUserDefaults] setObject:CLIENT_VERSION forKey:@"clientVersion"];
        [FUsersTool setDefaultUser];
    } else{
        NSLog(@"更新了APP");
        [[NSUserDefaults standardUserDefaults] setObject:CLIENT_VERSION forKey:@"clientVersion"];
      
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    FTabBarController *tabbarVC = [[FTabBarController alloc] init];
    self.window.rootViewController = tabbarVC;
    
    
    [self setUpKeyboardManager];
    
    self.userInfo = [FUserModel userFrom_NSUserDefaults];
    if (self.userInfo) {
        [[AppDefaultUtil sharedInstance] setLoginState:YES]; //测试登录
    }

    
    return YES;
}

- (void)setUserInfo:(FUserModel *)userInfo{
    _userInfo = userInfo;
    
    //    [self initFAccountCategaries];
    self.aFAccountCategaries = [FAccountRecordSaveTool readLocalUserAccountCategaries];
    
    [self initcurrentMonthRecord];
}

- (void)initcurrentMonthRecord{
    
    self.currentMonthRecord = [FAccountRecordSaveTool readLoaclCurrentMonthBlanceRecords];
    if (!self.currentMonthRecord) {//
        
//        // 6月份 //MM月dd日HH时mm分 yyyy年MM月
//        NSMutableArray *monthExpandse = [NSMutableArray array];
//        NSMutableArray *monthincome = [NSMutableArray array];
//        NSInteger day = [NSDate date].day;
//        int month = (int)[NSDate date].month;
//        for (int i = 1; i<= day; i++) {// 支出一天1-2个，收入有6份收入
//            
//            NSString *time_minut = [NSString stringWithFormat:@"%02d月%02d日%02d时%02d分", month, i, 9+i%12, 10+i%20];
//            NSString *time_month = [NSString stringWithFormat:@"2018年%02d月", month];
//            FAccountRecord *expandse = [FAccountRecord recordRandomExpandseWithtime_minute:time_minut time_month:time_month];
//            [monthExpandse addObject:expandse];
//            if (i%5 == 0) {
//                
//                FAccountRecord *expandse = [FAccountRecord recordRandomExpandseWithtime_minute:time_minut time_month:time_month];
//                [monthExpandse addObject:expandse];
//                
//                FAccountRecord *income = [FAccountRecord recordRandomIncomeWithtime_minute:time_minut time_month:time_month];
//                [monthincome addObject:income];
//            }
//        }
//        FCurrentMonthRecord *monthBalance = [FCurrentMonthRecord new];
//        monthBalance.expandseArr = monthExpandse.mutableCopy;
//        monthBalance.incomeArr = monthincome.mutableCopy;
//        
//        self.currentMonthRecord = monthBalance;
    }
}



//- (void)initFAccountCategaries{
//    // 编辑过
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *filePathName = [path stringByAppendingPathComponent:@"AccoutCategeries.plist"];
//    FAccountCategaries *bean = [FAccountCategaries mj_objectWithFile:filePathName];
//    if (bean) {// 读取用户自定义的数据
//        self.aFAccountCategaries = bean;
//    }else{// 读取APP内部设定的数据
//
//        NSString *AccoutCategeriesPath = [[NSBundle mainBundle] pathForResource:@"AccoutCategeries" ofType:@"plist"];
//        self.aFAccountCategaries = [FAccountCategaries mj_objectWithFile:AccoutCategeriesPath];
//    }
//}


- (void)generateMonthBlance{
    // 6月份 //MM月dd日HH时mm分 yyyy年MM月
    NSMutableArray *monthExpandse = [NSMutableArray array];
    NSMutableArray *monthincome = [NSMutableArray array];
    //    NSInteger day = [NSDate date].day;
    //    int month = [NSDate date].month;
    for (int i = 1; i<= 30; i++) {// 支出一天1-2个，收入有6份收入
        
        NSString *time_minut = [NSString stringWithFormat:@"04月%02d日%02d时%02d分", i, 9+i%12, 10+i%20];
        NSString *time_month = [NSString stringWithFormat:@"2018年04月"];
        FAccountRecord *expandse = [FAccountRecord recordRandomExpandseWithtime_minute:time_minut time_month:time_month];
        [monthExpandse addObject:expandse];
        if (i%5 == 0) {
            
            FAccountRecord *expandse = [FAccountRecord recordRandomExpandseWithtime_minute:time_minut time_month:time_month];
            [monthExpandse addObject:expandse];
            
            FAccountRecord *income = [FAccountRecord recordRandomIncomeWithtime_minute:time_minut time_month:time_month];
            [monthincome addObject:income];
        }
    }
    FCurrentMonthRecord *moth4 = [FCurrentMonthRecord new];
    moth4.expandseArr = monthExpandse.mutableCopy;
    moth4.incomeArr = monthincome.mutableCopy;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePathName = [path stringByAppendingPathComponent:@"F_default_201804.txt"];
    
    NSDictionary *month4Account = [moth4 mj_JSONObject];
    NSString *jsonString = [month4Account mj_JSONString];
    
    [jsonString writeToFile:filePathName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)generatePlist{
    
    NSMutableArray *arrtemp = [NSMutableArray array];
    FSubType *sub1, *sub2, *sub3, *sub4, *sub5, *sub6;
    sub1 = [FSubType subTypeWithName:@"早午晚餐"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"烟茶水"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"水果零食"];
    [arrtemp addObject:sub3];
    FFirstType *firstType1 = [FFirstType firstTypeWithName:@"食品酒水" budget:0 subTypeArr:arrtemp.copy];
    
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"日常用品"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"回电煤气"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"房租"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"物业管理"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"维修保养"];
    [arrtemp addObject:sub5];
    FFirstType *firstType2 = [FFirstType firstTypeWithName:@"居家物业" budget:0 subTypeArr:arrtemp.copy];
    
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"公共交通"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"打车"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"租车"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"私家车"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"包车"];
    [arrtemp addObject:sub5];
    FFirstType *firstType3 = [FFirstType firstTypeWithName:@"行车交通" budget:0 subTypeArr:arrtemp.copy];
    
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"运动健身"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"腐败聚会"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"休闲玩乐"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"宠物宝贝"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"旅游度假"];
    [arrtemp addObject:sub5];
    sub6 = [FSubType subTypeWithName:@"酒店费"];
    [arrtemp addObject:sub6];
    FFirstType *firstType4 = [FFirstType firstTypeWithName:@"休闲娱乐" budget:0 subTypeArr:arrtemp.copy];
    
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"书报杂志"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"培训"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"数码装备"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"教材"];
    [arrtemp addObject:sub4];
    FFirstType *firstType5 = [FFirstType firstTypeWithName:@"学习进修" budget:0 subTypeArr:arrtemp.copy];
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"送礼"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"请客"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"孝敬长辈"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"还钱"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"慈善捐助"];
    [arrtemp addObject:sub5];
    sub6 = [FSubType subTypeWithName:@"酒席红包"];
    [arrtemp addObject:sub6];
    FFirstType *firstType6 = [FFirstType firstTypeWithName:@"人情来往" budget:0 subTypeArr:arrtemp.copy];
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"药品费"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"保健费"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"美容费"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"治疗费"];
    [arrtemp addObject:sub4];
    FFirstType *firstType7 = [FFirstType firstTypeWithName:@"医疗保健" budget:0 subTypeArr:arrtemp.copy];
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"银行手续"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"投资亏损"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"按揭还款"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"消费税收"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"利息支出"];
    [arrtemp addObject:sub5];
    sub6 = [FSubType subTypeWithName:@"赔偿罚款"];
    [arrtemp addObject:sub6];
    FFirstType *firstType8 = [FFirstType firstTypeWithName:@"金融保险" budget:0 subTypeArr:arrtemp.copy];
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"其它支出"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"意外丢失"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"烂账损失"];
    [arrtemp addObject:sub3];
    FFirstType *firstType9 = [FFirstType firstTypeWithName:@"其它杂项" budget:0 subTypeArr:arrtemp.copy];
    
    NSMutableArray *expandesArr = [NSMutableArray arrayWithObjects:firstType1, firstType2, firstType3, firstType4, firstType5, firstType6, firstType7, firstType8, firstType9, nil];
    
    // 收入
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"工资收入"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"利息收入"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"加班收入"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"奖金收入"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"投资收入"];
    [arrtemp addObject:sub5];
    sub6 = [FSubType subTypeWithName:@"兼职收入"];
    [arrtemp addObject:sub6];
    FSubType *sub7 = [FSubType subTypeWithName:@"出差收入"];
    [arrtemp addObject:sub7];
    FFirstType *firstType10 = [FFirstType firstTypeWithName:@"职业收入" budget:0 subTypeArr:arrtemp.copy];
    
    [arrtemp removeAllObjects];
    sub1 = [FSubType subTypeWithName:@"礼金收入"];
    [arrtemp addObject:sub1];
    sub2 = [FSubType subTypeWithName:@"中奖收入"];
    [arrtemp addObject:sub2];
    sub3 = [FSubType subTypeWithName:@"意外来钱"];
    [arrtemp addObject:sub3];
    sub4 = [FSubType subTypeWithName:@"经营所得"];
    [arrtemp addObject:sub4];
    sub5 = [FSubType subTypeWithName:@"信用卡还款"];
    [arrtemp addObject:sub5];
    FFirstType *firstType11 = [FFirstType firstTypeWithName:@"其它收入" budget:0 subTypeArr:arrtemp.copy];
    
    NSMutableArray *incomeArr = [NSMutableArray arrayWithObjects:firstType10, firstType11, nil];
    
    
    NSMutableArray *accountArr = [NSMutableArray arrayWithObjects:@"现金（RMB)", @"银行卡", @"支付宝", @"微信", @"其他", nil];
    
    FAccountCategaries *category = [[FAccountCategaries alloc] init];
    category.expensesTypeArr = expandesArr;
    category.incomeTypeArr = incomeArr;
    category.accountTypeArr = accountArr;
    
    self.aFAccountCategaries = category;
    NSArray *plistWriteArr = [category mj_JSONObject];
    
    NSString *cachepath =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
    NSString *filePathName = [cachepath stringByAppendingPathComponent:@"AccoutCategeries.plist"];
    
    [plistWriteArr writeToFile:filePathName atomically:YES];
    
    //    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"AccoutCategeries" withExtension:@"plist"];
    plistWriteArr = [NSArray arrayWithContentsOfFile:filePathName];
    DLOG(@"path = %@, result = %@", filePathName, plistWriteArr);
}

#pragma  mark - 以下自定义方法
- (void)setUpKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.shouldShowToolbarPlaceholder = NO;
    manager.toolbarManageBehaviour = IQAutoToolbarByTag;
    //    manager.previousNextDisplayMode = IQPreviousNextDisplayModeDefault;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [self.userInfo saveTo_NSUserDefaults];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
