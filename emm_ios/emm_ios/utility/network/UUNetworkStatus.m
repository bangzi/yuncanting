//
//  UUNetworkStatus.m
//  emm_ios
//
//  Created by uusafe on 16/4/8.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUNetworkStatus.h"

@implementation UUNetworkStatus
 /**创建单例对象*/
+ (instancetype)shareManager
{
    static UUNetworkStatus * manager = nil;
    if (manager == nil) {
        manager = [[UUNetworkStatus alloc] init];
    }
    return manager;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self startMonitorNetwork];
    }
    return self;
}
- (void)startMonitorNetwork
{
    /*
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,//未识别的网络
     AFNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
     AFNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
     AFNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
     };
     */
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        self.status = status;
    }];
    //开始监听
    [manager startMonitoring];
}
- (AFNetworkReachabilityStatus)isStatus
{
    return self.status;
}
@end
