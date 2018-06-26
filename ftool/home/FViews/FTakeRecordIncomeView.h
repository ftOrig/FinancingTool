//
//  FTakeRecordIncomeView.h
//  ftool
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTakeRecordIncomeView : UIView


@property (nonatomic,strong) FAccountRecord *aincomeRecord;
@property (nonatomic, weak) id<UIViewOutterDelegate> delegate;
// 信息完成检查
- (BOOL)infoDoneCheck;
@end
