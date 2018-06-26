//
//  FAccountRecord.h
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseEntity.h"

@class FFirstType, FSubType, FAccountRecord;

@interface FCurrentMonthRecord : BaseEntity
// 在有编辑的地方记得保存到本地doctment，下次启动才能读取到，否则数据丢失
@property (nonatomic,strong) NSMutableArray<FAccountRecord *> *incomeArr;
@property (nonatomic,strong) NSMutableArray<FAccountRecord *> *expandseArr;
@end


@interface FAccountRecord : BaseEntity

@property (nonatomic,assign) CGFloat amount;

@property (nonatomic,strong) FFirstType *firstType;
@property (nonatomic,strong) FSubType *subType;

@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, copy) NSString *time_minute;//MM月dd日HH时mm分
@property (nonatomic, copy) NSString *time_month;// yyyy年MM月
@property (nonatomic, copy) NSString *remarks;

- (void)copyPropertyWithRecord:(FAccountRecord *)record;
// 随机生成收入记录
+ (instancetype)recordRandomIncomeWithtime_minute:(NSString *)time_minute time_month:(NSString *)time_month;

// 随机生成支出记录
+ (instancetype)recordRandomExpandseWithtime_minute:(NSString *)time_minute time_month:(NSString *)time_month;
@end
