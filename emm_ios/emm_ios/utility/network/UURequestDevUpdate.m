//
//  UURequestDevUpdate.m
//  emm_ios
//
//  Created by maqj on 4/19/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UURequestDevUpdate.h"
#import "BaseHeader.h"
#import "UULocalPersistenceUtil.h"
#import "DeviceInfo.h"
#import "UUID.h"

@implementation UURequestDevUpdate
- (UURequestTestType)kindOfTest{
    return UURequestTestTypeNone;
}

- (UURequestMethod)requestMethod{
    return UURequestMethodPost;
}

- (NSDictionary*)successResultForTest{
    return @{@"status":@(200)};
}

//- (NSString*)baseURLString {
//    return BASEURL;
//}

- (NSString*)serviceURLSuffix {
    return @"/api/period/report";
}

- (NSDictionary*)httpBody{
    
    NSString *securityId = [UULocalPersistenceUtil sharedInstance].securityId;
    NSString *deviceType = [DeviceInfo DeviceType];
    NSString *deviceName = [DeviceInfo DeviceName];
    NSString *systemVersion = [DeviceInfo DeviceSystemVersion];
    NSInteger powerStatus = [DeviceInfo DeviceSystemPowerStatus];
    NSInteger storageSize = [DeviceInfo freeDiskSpace];
    NSInteger physicalMemory = [DeviceInfo physicalMemory];

    return @{@"sign":@"test_sign",
             @"token":[UULocalPersistenceUtil sharedInstance].sessionToken,
             @"type":@"device",
             @"companyCode":[UULocalPersistenceUtil sharedInstance].loginCompanyCode,
             @"data":@{@"appInfo":[DeviceInfo installedAppsId],
                       @"deviceInfo":@{
                               @"securityId":securityId,
                               @"isRoot":@([DeviceInfo isJailbreaked]?1:2),
                               @"wifiMac":securityId,
                               @"osPlatform":@"IOS",
                               @"osModel":@"iPhone",
                               @"belongType":@"PUB_DEVICE_BELONG_STAFF",
                               @"deviceName":deviceName,
                               @"osVersion":systemVersion,
                               @"deviceManufacturer":@"apple",
                               @"powerStatus":@(powerStatus),
                               @"storageSize":@(storageSize),
                               @"physicalMemory":@(physicalMemory),
                               @"deviceType":deviceType,
                               @"pushToken":[UULocalPersistenceUtil sharedInstance].pushToken
                               }
                       }
             };
}

@end
