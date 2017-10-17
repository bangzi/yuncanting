//
//  DeviceInfo.h
//  emm_ios
//
//  Created by uusafe on 16/3/28.
//  Copyright © 2016年 uusafe. All rights reserved.
//

//TODO: 网络状态，网络状态改变通知？
//TODO: 正在使用的wifi名称
//TODO: 运营商信息？
//TODO: 内存状态？
//TODO: 磁盘剩余空间

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
@interface DeviceInfo : NSObject
+ (NSString *)DeviceName;

+ (NSString *)DeviceSystemVersion;

+ (NSString *)DeviceUDID;

+ (NSString *)DeviceTelephony;

+ (NSString *)DeviceNetworkType;

+ (NSString *)DeviceBatteryInfo;

+ (NSString *)DeviceModel;

+ (NSString *)getUpTime;

+ (NSInteger)DeviceSystemPowerStatus;

+ (float)DeviceTotalDiskSpace;

+ (NSString *)DeviceType;

+ (NSInteger)freeMemory;

+ (NSInteger)physicalMemory;

+ (long long)freeDiskSpace;

+ (NSString*)SSIDName;

+ (BOOL)networkAvailable;

+ (NSString*)carrierName;

+ (NSArray*)installedAppsId;

+ (BOOL)isJailbreaked;

@end
