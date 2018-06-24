//
//  FAccountCategaries.h
//  ftool
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@class FFirstType, FSubType;
// 记账类别
@interface FAccountCategaries : BaseEntity

@property (nonatomic, copy) NSMutableArray<FFirstType *> *expensesTypeArr;
@property (nonatomic, copy) NSMutableArray<FFirstType *> *incomeTypeArr;
@property (nonatomic, copy) NSMutableArray<NSString *> *accountTypeArr;
@end


@interface FFirstType : BaseEntity

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic,assign) CGFloat budget;
@property (nonatomic, copy) NSMutableArray<FSubType *> *subTypeArr;

+ (instancetype)firstTypeWithName:(NSString *)name budget:(CGFloat)budget subTypeArr:(NSMutableArray<FSubType *> *)SubTypeArr;
@end

@interface FSubType : BaseEntity

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isEditable;


+ (instancetype)subTypeWithName:(NSString *)name;
@end