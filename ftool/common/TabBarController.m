//
//  TabBarController.m
//  SP2P_10
//
//  Created by Jerry on 15/8/25.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//  加载所有模块控制器

#import "TabBarController.h"

//#import "LoginViewController.h"
#import "FHomeViewController.h"
#import "FCounterViewController.h"
#import "Macros.h"
#import "AppDefaultUtil.h"

@class FinanceViewController;
@class LoanViewController;
@class CapitalViewController;

@interface TabBarController ()

@end

@implementation TabBarController

+ (TabBarController *)shareInstance {
    static TabBarController *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectIndex:) name:CHANGETABBAR object:nil];

	//[self.tabBar setDelegate:self];
 
    [[UITabBarItem appearance] setTitleTextAttributes:                                                  [NSDictionary dictionaryWithObjectsAndKeys:baseNavColor,NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
   
    UITabBarItem *tabbarItem0 = [self getBarItemWithTitle:@"钱工具" imageName:@"tab_home"];
    UITabBarItem *tabbarItem1 = [self getBarItemWithTitle:@"计算器" imageName:@"tab_finance"];
//    UITabBarItem *tabbarItem2 = [self getBarItemWithTitle:@"我的" imageName:@"tab_myWealth"];
  
    
    FHomeViewController *homeView = [[FHomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeView];
    homeNav.tabBarItem = tabbarItem0;
    
    FCounterViewController *counterView = [[FCounterViewController alloc] init];
    UINavigationController *counterNav = [[UINavigationController alloc]initWithRootViewController:counterView];
    counterNav.tabBarItem = tabbarItem1;
    
//    UINavigationController *capitalView = (UINavigationController *)[[UIStoryboard storyboardWithName:@"Capital" bundle:nil] instantiateInitialViewController];
//    capitalView.tabBarItem = tabbarItem2;

    
    
    
    self.viewControllers = @[homeNav,counterView ];
    
//    if (IS_VISITOR)//进入程序后进入理财模块
//    {
        self.delegate = self;
        [self setSelectedIndex:0];
        
//    }else{
//        [self setSelectedIndex:2];
//    }
}

/*获取底部栏按钮*/
- (UITabBarItem *)getBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"_select"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    
    return tabbarItem;
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断的是当前点击的tabBarItem的标题
    if ([viewController.tabBarItem.title isEqualToString:@"我的"] && ![[AppDefaultUtil sharedInstance]isLoginState]) {
        
        //如果未登录，则跳转登录界面
//        LoginViewController *loginView = [[LoginViewController alloc] init];
//        MyNavigationController *loginNVC = [[MyNavigationController alloc] initWithRootViewController:loginView];
//        loginView.backType = MyWealth;
//        [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginNVC animated:YES completion:nil];
        
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark - 跳转指定tabbar
- (void)changeSelectIndex:(NSNotification *)note
{
    NSInteger index = [[note object]integerValue];
    [self setSelectedIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
