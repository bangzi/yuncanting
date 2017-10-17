//
//  UUNetworkStatus.h
//  emm_ios
//
//  Created by uusafe on 16/4/8.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
@interface UUNetworkStatus : NSObject
@property (nonatomic,assign) AFNetworkReachabilityStatus status;
+ (instancetype)shareManager;
- (AFNetworkReachabilityStatus)status:(AFNetworkReachabilityStatus)status;
@end
