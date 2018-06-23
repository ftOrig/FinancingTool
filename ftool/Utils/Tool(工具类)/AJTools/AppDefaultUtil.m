//
//  AppDefaultUtil.m
//  SP2P_7
//
//  Created by 李小斌 on 14+9+30.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import "AppDefaultUtil.h"


static NSString * const Key_EmailAdress = @"EmailAdress";
@implementation AppDefaultUtil

static NSUserDefaults *defaults;
+ (void)load
{
    defaults = [NSUserDefaults standardUserDefaults];
}


+ (void)setEmailAdress:(NSString *)emailAdress
{
    [defaults setObject:emailAdress forKey:Key_EmailAdress];
    [defaults synchronize];
}
+ (NSString *)getEmailAdress
{
    return [defaults objectForKey:Key_EmailAdress];
}
@end
