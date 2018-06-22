//
//  TabBarController.h
//  SP2P_10
//
//  Created by Jerry on 15/8/25.
//  Copyright (c) 2015年 EIMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>

+ (TabBarController *)shareInstance;

@end
