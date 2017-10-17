//
//  UURegisterRequst.m
//  emm_ios
//
//  Created by uusafe on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURegisterRequest.h"
#import "UULocalPersistenceUtil.h"
#import "DeviceInfo.h"
#import "BaseHeader.h"
#define ISROOT 1
#define NOTROOT 2
@implementation UURegisterRequest

- (UURequestMethod)requestMethod {
    return UURequestMethodPost;
}

- (NSString *)serviceURLSuffix {
    return @"/api/device/reg";
}

- (NSDictionary *)httpBody {
    NSString *securityId = [UULocalPersistenceUtil sharedInstance].deviceUDID;
    NSString *sessionUUID = [UULocalPersistenceUtil sharedInstance].sessionUUID;
    NSString *deviceUDID = securityId;
    NSString *deviceType = [DeviceInfo DeviceType];
    NSString *deviceName = [DeviceInfo DeviceName];
    
    NSString *sessionToken = [UULocalPersistenceUtil sharedInstance].sessionToken;
    NSString *systemVersion = [DeviceInfo DeviceSystemVersion];
    NSString *userName = [UULocalPersistenceUtil sharedInstance].loginUserName;
    NSString *password = [UULocalPersistenceUtil sharedInstance].loginPassword;
    NSString *pushToken = [UULocalPersistenceUtil sharedInstance].pushToken;
    
    NSString *companyCode = [UULocalPersistenceUtil sharedInstance].loginCompanyCode;
    
    NSInteger powerStatus = [DeviceInfo DeviceSystemPowerStatus];
    //  BOOL isRoot = [DeviceInfo isJailbreaked];
    NSInteger storageSize = [DeviceInfo freeDiskSpace];
    NSInteger physicalMemory = [DeviceInfo physicalMemory];
    NSDictionary *param = @{
                            @"userName":userName,
                            @"password":password,
                            @"deviceInfo":@{
                                    @"securityId":securityId,
                                    @"isRoot":[NSNumber numberWithInteger:[DeviceInfo isJailbreaked]?ISROOT:NOTROOT],
                                    @"wifiMac":securityId,
                                    @"osPlatform":@"IOS",
                                    @"osModel":@"iPhone",
                                    @"belongType":@"PUB_DEVICE_BELONG_STAFF",
                                    @"deviceName":deviceName,
                                    @"osVersion":systemVersion,
                                    @"deviceManufacturer":@"apple",
                                    @"powerStatus":[NSNumber numberWithInteger:powerStatus],
                                    @"storageSize":[NSNumber numberWithInteger:storageSize],
                                    @"physicalMemory":[NSNumber numberWithInteger:physicalMemory],
                                    @"deviceType":deviceType,
                                    @"pushToken":pushToken,
                                    @"uuid":sessionUUID,
                                    @"udid":deviceUDID
                                    },
                            @"http.protocol.content-charset":@"UTF-8",
                            @"companyCode":companyCode
                            };
    return param;
}
@end
