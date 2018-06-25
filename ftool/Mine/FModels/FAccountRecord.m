//
//  FAccountRecord.m
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FAccountRecord.h"

@implementation FCurrentMonthRecord

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"incomeArr": [FAccountRecord class], @"expandseArr": [FAccountRecord class]};
}
@end

@implementation FAccountRecord

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"subType": [FSubType class], @"firstType": [FFirstType class]};
}

+ (instancetype)recordRandomIncomeWithtime_minute:(NSString *)time_minute time_month:(NSString *)time_month{
    
    FAccountRecord *bean = [[FAccountRecord alloc] init];
    bean.time_month = time_month;
    bean.time_minute = time_minute;
    
    int x = arc4random() % 100000;
    if (x==0) {
        x += 1;
    }
    CGFloat amount = x/100.f;
    bean.amount = amount;
    
//    NSArray *firstArr = AppDelegateInstance.aFAccountCategaries.incomeTypeArr
//    bean.firstType =
    return bean;
}


// 随机生成支出记录
+ (instancetype)recordRandomExpandseWithtime_minute:(NSString *)time_minute time_month:(NSString *)time_month
{
    FAccountRecord *bean = [[FAccountRecord alloc] init];
return bean;
}
@end
