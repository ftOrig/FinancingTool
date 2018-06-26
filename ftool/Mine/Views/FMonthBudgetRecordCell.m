//
//  FMonthBudgetRecordCell.m
//  ftool
//
//  Created by admin on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FMonthBudgetRecordCell.h"

@interface FMonthBudgetRecordCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *budgetL;
@property (weak, nonatomic) IBOutlet UILabel *usedL;
@property (weak, nonatomic) IBOutlet UILabel *leftBudgetL;
@property (weak, nonatomic) IBOutlet LDProgressView *progressV;
@property (weak, nonatomic) IBOutlet UITextField *budgetField;

@end

@implementation FMonthBudgetRecordCell

- (void)setAfirstType:(FFirstType *)afirstType{
    
    _afirstType = afirstType;
    
    self.nameL.text = afirstType.name;
    self.imgV.image = [UIImage imageNamed:afirstType.iconName];
    self.budgetField.text = [NSString stringWithFormat:@"%.2f", afirstType.budget];
    
    // 支出
    CGFloat monthExpandse = 0;
    for (FAccountRecord *expandseRecord in AppDelegateInstance.currentMonthRecord.expandseArr) {
        
        if ([expandseRecord.firstType.name isEqualToString:afirstType.name]) {
            monthExpandse += expandseRecord.amount;
        }
    }
    
    NSString *expandseStr = [NSString stringWithFormat:@"支出 %.2f", monthExpandse];
    self.usedL.attributedText = [MyTools getAttributedStringWithText:expandseStr start:3 end:expandseStr.length textColor:[UIColor ys_green] textFont:self.usedL.font];
    
    self.progressV.progress = afirstType.budget>0? monthExpandse/ afirstType.budget:0;
    NSString *leftBudgetStr = [NSString stringWithFormat:@"剩余 %.2f", afirstType.budget - monthExpandse];
    self.leftBudgetL.attributedText = [MyTools getAttributedStringWithText:leftBudgetStr start:3 end:leftBudgetStr.length textColor:[UIColor ys_red] textFont:self.leftBudgetL.font];
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.progressV.color = NavgationColor;
    self.progressV.background = RGB(238,238,238);
    self.progressV.flat = @YES;
    self.progressV.animate = @NO;
    self.progressV.showStroke = @NO;
    self.progressV.showText = @NO;
    self.progressV.showBackground = @YES;
    self.progressV.showBackgroundInnerShadow = @NO;
    self.progressV.outerStrokeWidth = @(0.f);
    self.progressV.progressInset = @(0.f);
    self.progressV.borderRadius = @(2.5);
    self.progressV.type = LDProgressSolid;// LDProgressGradient/ LDProgressStripes
    self.progressV.progress = 0.4656;
    
    self.budgetField.delegate = self;
    self.budgetField.text = @"0.00";
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (CGRectContainsPoint(self.budgetL.frame, point)) {
        return self.budgetField;
    }
    return [super hitTest:point withEvent:event];
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//
//    self.afirstType.budget = textField.
//}
@end
