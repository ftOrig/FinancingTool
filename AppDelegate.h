//
//  AppDelegate.h
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAccountCategaries;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FUserModel *userInfo;
@property (nonatomic,strong) FAccountCategaries *aFAccountCategaries;
@end

