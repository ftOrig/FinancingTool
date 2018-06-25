//
//  FAccountRecord.m
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FAccountRecord.h"

@implementation FAccountRecord

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"subType": [FSubType class], @"firstType": [FFirstType class]};
}

@end
