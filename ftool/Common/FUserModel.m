//
//  UserModel.m
//  dawe
//
//  Created by dawe on 16-8-12.
//  Copyright (c) 2016年 dawe. All rights reserved.
//

#import "FUserModel.h"
#import "AppDefaultUtil.h"
#import "AJExtension.h"
#import "Macros_AJ.h"

static NSString *const UserDefaultKey_userModel = @"userModel";
static NSString *const UserDefaultKey_closeGesture_AppendStr = @"CloseGesture";
@implementation FUserModel

static NSUserDefaults *defaults;

// 相同的两个东西，但是接口用了2个字段，所以做个同步
- (void)setIs_borrow:(BOOL)is_borrow
{
    _type = _is_borrow = is_borrow;
}

- (void)setType:(int)type
{
    _type = _is_borrow = type;
}
+ (void)load
{
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)setIsCloseGesture:(BOOL)isCloseGesture
{
    _isCloseGesture = isCloseGesture;
    
    NSString *gestureKey = [self.phone appendStr:UserDefaultKey_closeGesture_AppendStr];
    [defaults setBool:self.isCloseGesture forKey:gestureKey];
    [defaults synchronize];
}

+ (FUserModel *)sharedUser
{
//    static UserModel *userModel_p = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        userModel_p = [[UserModel alloc] init];
//    });
    return AppDelegateInstance.userInfo;
}

- (NSString *)token
{ /*
     如果为空时候，去数据库中拿该登录名的缓存的ticket
     */
    if (!_token || [_token isKindOfClass:[NSNull class]]) {
        _token = [defaults valueForKey:@"userToken"];
    }
    return _token;
}

@end


@implementation FUserModel(Archiver)

- (void)saveTo_NSUserDefaults
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:data forKey:UserDefaultKey_userModel];
    
    // 数据存储
//    [userdafault setValue:self.phone forKey:@"userPhone"];
    [defaults setValue:self.token forKey:@"userToken"];
    
    NSString *gestureKey = [self.phone appendStr:UserDefaultKey_closeGesture_AppendStr];
    DLOG(@"--%d", [defaults boolForKey:gestureKey]);
    self.isCloseGesture = [defaults boolForKey:gestureKey];
    [defaults synchronize];
}

+ (instancetype)userFrom_NSUserDefaults
{
    NSData *userData = [defaults objectForKey:UserDefaultKey_userModel];
    if (!userData) return nil;
    FUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    NSString *gestureKey = [user.phone appendStr:UserDefaultKey_closeGesture_AppendStr];
    user.isCloseGesture = [defaults boolForKey:gestureKey];
    return user;
}

+ (void)clearUser
{
}
//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        Class c = self.class;
        // 截取类和父类的成员变量
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                id value = [aDecoder decodeObjectForKey:key];
                if (value) {
                    [self setValue:value forKey:key];
                }
            }
            // 获得c的父类
            c = [c superclass];
            free(ivars);
        }
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [self valueForKey:key];
            
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
}
@end
