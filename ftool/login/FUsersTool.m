//
//  FUsersTool.m
//  ftool
//
//  Created by apple on 2018/6/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FUsersTool.h"

#define KEY_DefaultUser @"FkDefaultUser" //默认用户

#define KEY_UserList @"FkUserList" //用户列表

#define defName @"13388888888" //默认用户名
#define defNamePass @"123456"  //默认用户密码

@implementation FUsersTool

+(void)setDefaultUser{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defUser = [NSDictionary dictionaryWithObjectsAndKeys:@"name",defName, @"pwd", defNamePass, nil];
    [defaults setObject:defUser forKey:KEY_DefaultUser];
}

+(BOOL) loginUser:(NSString *)name andPassword:(NSString *)pwd{
    
    return NO;
}

+(BOOL) registUser:(NSString *)name andPassword:(NSString *)pwd{
    
    return NO;
}

+(BOOL) isExsits:(NSString *)name{
    
    return NO;
}

@end
