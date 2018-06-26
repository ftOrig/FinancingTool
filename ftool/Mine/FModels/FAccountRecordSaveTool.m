//
//  FAccountRecordSaveTool.m
//  ftool
//
//  Created by admin on 2018/6/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FAccountRecordSaveTool.h"

@implementation FAccountRecordSaveTool

+ (BOOL)saveCurrentMonthBlanceRecords
{
    FAccountRecord *bean = AppDelegateInstance.currentMonthRecord.expandseArr.firstObject;
    NSDate *lastDate = [NSDate getDate:bean.time_month format:@"yyyy年MM月"];
    NSInteger year = lastDate.year;
    NSInteger month = lastDate.month;
    NSString *targetDateStr = [NSString stringWithFormat:@"%04d%02d", (int)year, (int)month];
    
    NSString *fileName = [NSString stringWithFormat:@"F_%@_%@.txt", @"default", targetDateStr];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *filePathName = [path stringByAppendingPathComponent:fileName];
    
    
    NSDictionary *month4Account = [AppDelegateInstance.currentMonthRecord mj_JSONObject];
    NSString *jsonString = [month4Account mj_JSONString];
    NSString *jsonstringLast = [NSString stringWithContentsOfFile:filePathName encoding:NSUTF8StringEncoding error:nil];
    
    if ([[jsonstringLast md5] isEqualToString:[jsonString md5]]) {// 未更改
        return YES;
    }
    
    BOOL isSuccess = [jsonString writeToFile:filePathName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    return isSuccess;
}


+ (FCurrentMonthRecord *)readLoaclCurrentMonthBlanceRecords{
    
    NSInteger year = [NSDate date].year;
    NSInteger month = [NSDate date].month;
    NSString *targetDateStr = [NSString stringWithFormat:@"%04d%02d", (int)year, (int)month];
    
    NSString *fileName = [NSString stringWithFormat:@"F_%@_%@.txt", @"default", targetDateStr];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *filePathName = [path stringByAppendingPathComponent:fileName];
    
    NSString *jsonstring = [NSString stringWithContentsOfFile:filePathName encoding:NSUTF8StringEncoding error:nil];
    
    FCurrentMonthRecord *targetMonthRecord = [FCurrentMonthRecord mj_objectWithKeyValues:jsonstring];
    
    return targetMonthRecord;
}





- (BOOL)saveAccountCategaries{

   
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePathName = [path stringByAppendingPathComponent:@"AccoutCategeries.plist"];
    
    // 写入plist
    NSDictionary *dic = [AppDelegateInstance.aFAccountCategaries mj_JSONObject];
    NSString *jsonstr = [dic mj_JSONString];
    
    NSDictionary *dicLast = [NSDictionary dictionaryWithContentsOfFile:filePathName];
    NSString *jsonstrLast = [dicLast mj_JSONString];
    if ([[jsonstr md5] isEqualToString:[jsonstrLast md5]]) {
        return YES;
    }
    
    if ([dic writeToFile:filePathName atomically:YES]) {
        
        return YES;
        DLOG(@"写入成功");
    }else{
        
        DLOG(@"写入失败");
        return NO;
    }
}













@end
