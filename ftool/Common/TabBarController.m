//
//  TabBarController.m
//  Created by 周利强 on 15/8/10.
//  Copyright (c) 2015年 周利强. All rights reserved.
//

#import "TabBarController.h"
#import "FCounterViewController.h"
#import "FMineController.h"
#import "FHomeViewController.h"
#import "NavigationController.h"
#import "LoginViewController.h"

@interface TabBarController () < UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FHomeViewController *home = [[FHomeViewController alloc] init];
    home.title = @"首页";
    NavigationController *nav1 = [[NavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:nav1];

    FCounterViewController *vender = [[FCounterViewController alloc] init];
    vender.title = @"计算器";
    NavigationController *nav2 = [[NavigationController alloc] initWithRootViewController:vender];
    [self addChildViewController:nav2];
    
    FMineController *personal = [[FMineController alloc] init];
    personal.title = @"我的";
    NavigationController *nav3 = [[NavigationController alloc] initWithRootViewController:personal];
    [self addChildViewController:nav3];
    
    self.tabBar.tintColor = NavgationColor;
    if (isIOS10later) {
        self.tabBar.unselectedItemTintColor = [UIColor ys_darkGray];
    }
    UITabBarItem *tabbarItem0 = [self getBarItemWithTitle:@"首页" imageName:@"Tabbar_home_unselected"];
    nav1.tabBarItem = tabbarItem0;
    UITabBarItem *tabbarItem1 = [self getBarItemWithTitle:@"投资" imageName:@"Tabbar_finance_unselected"];
    nav2.tabBarItem = tabbarItem1;
    UITabBarItem *tabbarItem2 = [self getBarItemWithTitle:@"我的" imageName:@"Tabbar_my_unselected"];
    nav3.tabBarItem = tabbarItem2;
    
    self.delegate = self;

}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%s %@", __FUNCTION__, viewController.tabBarItem.title);
    //判断的是当前点击的tabBarItem的标题
    if ([viewController.tabBarItem.title isEqualToString:@"我的"] && ![[AppDefaultUtil sharedInstance]isLoginState]) {
        
        //如果未登录，则跳转登录界面
        LoginViewController *loginView = [[LoginViewController alloc] init];
        UINavigationController *loginNVC = [[UINavigationController alloc] initWithRootViewController:loginView];
//        loginView.backType = MyWealth;
        [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginNVC animated:YES completion:nil];
        
        return NO;
    }
    else{
        return YES;
    }
}

/*获取底部栏按钮*/
- (UITabBarItem *)getBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [[UIImage imageNamed:[imageName stringByReplacingOccurrencesOfString:@"unselected" withString:@"selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage tag:99];
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    return tabbarItem;
}

@end
