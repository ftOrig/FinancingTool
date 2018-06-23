//
//  AppDefaultUtil.h
// zhouliqiang
//

#import <Foundation/Foundation.h>

@interface AppDefaultUtil : NSObject



/** 发送结算详情/月账单到邮件，保存用户输入的邮箱地址 */
+ (void)setEmailAdress:(NSString *)emailAdress;
+ (NSString *)getEmailAdress;
@end
