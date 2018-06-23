//
//  FTakeRecordExpandView.m
//  ftool
//
//  Created by admin on 2018/6/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FTakeRecordExpandView.h"
#import "WSPlaceholderTextView.h"
#import "BRAddressModel.h"
#import "BRPickerView.h"
#import "NSDate+BRAdd.h"

@interface FTakeRecordExpandView()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) UILabel *expandCategeryL;
@property (nonatomic, weak) UILabel *accountCategeryL;
@property (nonatomic, weak) UILabel *dateL;
@property (nonatomic, weak) WSPlaceholderTextView *textView;
@end

@implementation FTakeRecordExpandView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AJWhiteColor;
        CGFloat leading = 15.f;
        UITextField *moneyF = [AJTextField textFieldWithFrame:RECT(leading, 0, MSWIDTH-2*leading, 80) delegate:self text:@"" textColor:[UIColor ys_green] textFont:40 placeholder:@"0.00" superview:self];
        moneyF.borderStyle = UITextBorderStyleNone;
        moneyF.keyboardType = UIKeyboardTypeDecimalPad;
        UIView *line = [UIView viewWithFrame:RECT(leading, moneyF.maxY, MSWIDTH-leading, .5) backgroundColor:[UIColor ys_grayLine] superview:self];
        
        self.expandCategeryL = [self addRowWithY:line.maxY Title:@"分类" touchaction:@selector(expandCategeryClick:)];
        
        self.accountCategeryL = [self addRowWithY:self.subviews.lastObject.maxY Title:@"账户" touchaction:@selector(accountCategeryClick:)];
        
        self.dateL = [self addRowWithY:self.subviews.lastObject.maxY Title:@"时间" touchaction:@selector(dateClick:)];
        
        WSPlaceholderTextView *textView = [WSPlaceholderTextView textViewWithFrame:RECT(leading, self.subviews.lastObject.maxY+20, MSWIDTH-2*leading, 200) textColor:[UIColor blackColor] bgColor:nil font:15 superV:self];
        textView.delegate = self;
        textView.placeholder = @"备注...";
        textView.placeholderColor = [UIColor ys_lightGray];
        ViewBorderRadius(textView, 2.f, .5, [UIColor ys_grayLine]);
        self.textView = textView;
        self.height = textView.maxY;
    }
    return self;
}


- (void)dateClick:(UIControl *)sender{
    
    NSDate *minDate = [NSDate setMonth:1 day:1];
    NSDate *maxDate = [NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日HH时mm分"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSDate *selectDate = [formatter dateFromString:self.dateL.text];
    [formatter setDateFormat:@"MM-dd HH:mm"];// view需要的格式
    NSString *defaultShow = [formatter stringFromDate:selectDate];
    [BRDatePickerView showDatePickerWithTitle:nil dateType:BRDatePickerModeMDHM defaultSelValue:defaultShow minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *resultStr) {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate *resultdate = [formatter dateFromString:resultStr];
        [formatter setDateFormat:@"MM月dd日HH时mm分"];
        DLOG(@"resultDate == %@", resultdate);

    } cancelBlock:nil];
}

- (void)accountCategeryClick:(UIControl *)sender
{
    FAccountCategaries *AccountCategary = AppDelegateInstance.aFAccountCategaries;
    [BRStringPickerView showStringPickerWithTitle:nil dataSource:AccountCategary.accountTypeArr defaultSelValue:nil resultBlock:^(id selectValue) {
        
        DLOG(@"accountCategeryClick : %@", selectValue);
    }];
}

- (void)expandCategeryClick:(UIControl *)sender
{
    FAccountCategaries *AccountCategary = AppDelegateInstance.aFAccountCategaries;
    
    NSMutableArray *tempArr1 = [NSMutableArray array];
    for (FFirstType *firstType in AccountCategary.expensesTypeArr) {
        
        BRProvinceModel *proviceModel = [[BRProvinceModel alloc]init];
        proviceModel.name = firstType.name;
        proviceModel.index = [AccountCategary.expensesTypeArr indexOfObject:firstType];
        NSArray *citylist = firstType.subTypeArr;
        NSMutableArray *tempArr2 = [NSMutableArray array];
        for (FSubType *subType in citylist) {
            BRCityModel *cityModel = [[BRCityModel alloc]init];
            cityModel.name = subType.name;
            cityModel.index = [citylist indexOfObject:subType];
            
            NSDictionary *cityDic = [subType mj_JSONObject];
            [tempArr2 addObject:cityDic];
        }
        proviceModel.citylist = [tempArr2 copy];
        NSDictionary *proviceDic = [proviceModel mj_JSONObject];
        [tempArr1 addObject:proviceDic];
    }
    DLOG(@"%@", tempArr1);
    // 【转换】：以@" "自字符串为基准将字符串分离成数组，如：@"浙江省 杭州市 西湖区" ——》@[@"浙江省", @"杭州市", @"西湖区"]
    NSArray *defaultSelArr = [self.expandCategeryL.text componentsSeparatedByString:@" -> "];
    defaultSelArr = defaultSelArr.count==2?defaultSelArr:nil;
    // NSArray *dataSource = [weakSelf getAddressDataSource];  //从外部传入地区数据源
    NSArray *dataSource = tempArr1; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeCity dataSource:dataSource defaultSelected:defaultSelArr isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        
    } cancelBlock:^{
        
    }];
}

- (UILabel *)addRowWithY:(CGFloat)y Title:(NSString *)title touchaction:(nonnull SEL)action{
    
    UIControl *view = [UIControl viewWithFrame:RECT(0, y, MSWIDTH, 90) backgroundColor:nil superview:self];
    [view addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleL = [UILabel labelWithFrame:RECT(15, 10, 100, 20) text:title textColor:[UIColor ys_darkGray] textFont:13 textAligment:NSTextAlignmentLeft superview:view];
    
    UILabel *contentL = [UILabel labelWithFrame:RECT(15, titleL.maxY + 8, MSWIDTH-30, 50) text:@"未选择" textColor:[UIColor ys_black] textFont:16 textAligment:NSTextAlignmentLeft superview:view];
    UIView *line = [UIView viewWithFrame:RECT(15, contentL.maxY + 5, MSWIDTH-15, .5) backgroundColor:[UIColor ys_grayLine] superview:view];
    line.tag = 90;
    contentL.backgroundColor = AJGrayBackgroundColor;
    CGFloat imgVW = 8.f;
    UIImageView *imgV = [UIImageView imageViewWithFrame:RECT(MSWIDTH - imgVW - 15, contentL.y, imgVW, contentL.height) imageFile:@"Payments_arrow" superview:view];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    return contentL;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length ==0) {
        return YES;
    }
    NSString *checkStr = [textField.text stringByAppendingString:string];
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL canInput = [predicte evaluateWithObject:checkStr] && (checkStr.doubleValue < 10000000);
    
    return canInput;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGFloat adjustOffset = 250 + self.height + 108 - MSHIGHT;
    if (adjustOffset > 0) {
        [UIView animateWithDuration:.25 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -adjustOffset);
        }];
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:.25 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    return YES;
}
@end
