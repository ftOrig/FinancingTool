//
//  AppDelegate.h
//  ftool
//
//  Created by apple on 2018/6/20.
//  Copyright © 2018年 apple. All rights reserved.
//

static NSString * const Filename_AprilBalance = @"F_default_201804.txt";
static NSString * const Filename_MayBalanceFilename = @"F_default_201805.txt";

#import <UIKit/UIKit.h>

@class FAccountCategaries, FCurrentMonthRecord;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FUserModel *userInfo;
@property (nonatomic,strong) FAccountCategaries *aFAccountCategaries;

@property (nonatomic,strong) FCurrentMonthRecord *currentMonthRecord;
@end

