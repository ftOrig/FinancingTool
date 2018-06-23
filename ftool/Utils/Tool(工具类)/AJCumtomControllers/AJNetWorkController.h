//
//  AJNetWorkController.h
//  SP2P
//
//  Created by Ajax on 16/2/29.
//  Copyright © 2016年 EIMS. All rights reserved.
//

#import "BaseViewController.h"

@protocol NetworkRefrenceProtocol <NSObject>

@optional
- (void)requestData;
- (void)initView;
@end

@interface AJNetWorkController : BaseViewController<NetworkRefrenceProtocol>

@end
