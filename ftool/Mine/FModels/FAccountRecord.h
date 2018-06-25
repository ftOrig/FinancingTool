//
//  FAccountRecord.h
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseEntity.h"

@class FFirstType, FSubType;
@interface FAccountRecord : BaseEntity

@property (nonatomic,assign) CGFloat amount;

@property (nonatomic,strong) FFirstType *firstType;
@property (nonatomic,strong) FSubType *subType;

@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *time_minute;//月日时分
@property (nonatomic, copy) NSString *time_month;// 年月
@property (nonatomic, copy) NSString *remarks;

//+ (instancetype)recordWithAmount:(CGFloat) 
@end
