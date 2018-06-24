//
//  FUsersTool.h
//  ftool
//  管理和保存默认用户及注册的用户
//  Created by apple on 2018/6/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FUsersTool : NSObject

+ (void)setDefaultUser;

//注册一个用户
+ (BOOL)registUser:(NSString *)name andPassword:(NSString *)pwd;

//用户登录
+ (BOOL)loginUser:(NSString *)name andPassword:(NSString *)pwd;

+ (BOOL)isExsits:(NSString* )name;

@end
