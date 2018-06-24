//
//  FTakeRecordExpandView.h
//  ftool
//
//  Created by admin on 2018/6/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTakeRecordExpandView : UIView

@property (nonatomic, weak) id<UIViewOutterDelegate> delegate;
// 信息完成检查
- (BOOL)infoDoneCheck;
@end
