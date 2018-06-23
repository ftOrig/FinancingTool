//
//  FAccountCategaries.h
//  ftool
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFirstType, FSubType;
// 记账类别
@interface FAccountCategaries : NSObject

@property (nonatomic, strong) NSMutableArray<FFirstType *> *expensesTypeArr;
@property (nonatomic, strong) NSMutableArray<FFirstType *> *incomeTypeArr;
@property (nonatomic, strong) NSMutableArray<NSString *> *accountTypeArr;
@end


@interface FFirstType : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic,assign) CGFloat budget;
@property (nonatomic, strong) NSMutableArray<FSubType *> *subTypeArr;

+ (instancetype)firstTypeWithName:(NSString *)name budget:(CGFloat)budget subTypeArr:(NSArray *)SubTypeArr;
@end

@interface FSubType : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isEditable;


//@property (nonatomic, strong) NSDictionary<NSString *> *subTypeArr;
@end
