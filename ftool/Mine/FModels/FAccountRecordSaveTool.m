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
    
//    NSString *userName = AppDelegateInstance.userInfo.phone?:@"default";
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
    
    NSString *userName = nil;
    if ([AppDelegateInstance.userInfo.phone isEqualToString:defName]) {
        
         userName = @"default";
    }else if(AppDelegateInstance.userInfo.phone.length>0){
        
        userName = AppDelegateInstance.userInfo.phone;
    }else{
        
        return nil;
    }

    NSString *fileName = [NSString stringWithFormat:@"F_%@_%@.txt", userName, targetDateStr];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *filePathName = [path stringByAppendingPathComponent:fileName];
    
    NSString *jsonstring = [NSString stringWithContentsOfFile:filePathName encoding:NSUTF8StringEncoding error:nil];
    
    FCurrentMonthRecord *targetMonthRecord = [FCurrentMonthRecord mj_objectWithKeyValues:jsonstring];
    
    return targetMonthRecord;
}


+ (FAccountCategaries *)readLocalUserAccountCategaries{
    
    // 用户是否默认用户
    // 用户是否是有效用户
    // 用户无效
    NSString *fileName = nil;
    if ([AppDelegateInstance.userInfo.phone isEqualToString:defName]) {
        
        fileName = @"AccoutCategeries.plist";
    }else if(AppDelegateInstance.userInfo.phone.length>0){
        
        fileName = [NSString stringWithFormat:@"F%@_AccoutCategeries.plist", AppDelegateInstance.userInfo.phone];
    }else{
        
        fileName = @"AccoutCategeries.plist";
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePathName = [path stringByAppendingPathComponent:fileName];
    FAccountCategaries *bean = [FAccountCategaries mj_objectWithFile:filePathName];
    if (bean) {// 读取用户自定义的数据
        return  bean;
    }else{// 读取APP内部设定的数据
        
        NSString *AccoutCategeriesPath = [[NSBundle mainBundle] pathForResource:@"AccoutCategeries" ofType:@"plist"];
        return  [FAccountCategaries mj_objectWithFile:AccoutCategeriesPath];
    }
}

+ (BOOL)saveAccountCategaries{

    NSString *fileName = nil;
    if ([AppDelegateInstance.userInfo.phone isEqualToString:defName]) {
        
        fileName = @"AccoutCategeries.plist";
    }else if(AppDelegateInstance.userInfo.phone.length>0){
        
        fileName = [NSString stringWithFormat:@"F%@_AccoutCategeries.plist", AppDelegateInstance.userInfo.phone];
    }else{
        
        fileName = @"AccoutCategeries.plist";
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePathName = [path stringByAppendingPathComponent:fileName];
    
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
