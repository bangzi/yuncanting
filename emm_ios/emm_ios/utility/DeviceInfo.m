//
//  DeviceInfo.m
//  emm_ios
//
//  Created by uusafe on 16/3/28.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "DeviceInfo.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "OpenUDID.h"
#import "SystemServices.h"

@implementation DeviceInfo
+ (NSString *)DeviceName
{
    return [[UIDevice currentDevice]name];
}

+ (NSString *)DeviceSystemVersion
{
    return [[UIDevice currentDevice]systemVersion];
}
+ (NSString *)DeviceUDID
{
    return [OpenUDID value];
    
   // return [[[UIDevice currentDevice]identifierForVendor]UUIDString];
}
+ (NSString *)DeviceTelephony
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    return [NSString stringWithFormat:@"%@",carrier];
}
+ (NSString *)DeviceNetworkType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *contectType = [ NSString stringWithFormat:@"%@",info.currentRadioAccessTechnology];
    return contectType;
}

+ (NSString *)DeviceBatteryInfo
{
    
    NSString *state =  [NSString stringWithFormat:@"%f",[UIDevice currentDevice].batteryState];
    
    return state;
}
+ (NSString *)DeviceModel
{
    NSString *phoneModel = [UIDevice currentDevice].model;
    return phoneModel;
}
+ (NSInteger)DeviceSystemPowerStatus
{
    double deviceLevel = [[SystemServices sharedServices] batteryLevel];
    
    return (NSInteger)deviceLevel;
    
}
+ (NSString *)getUpTime{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval timerInterval = [[NSProcessInfo processInfo]systemUptime];
    
    NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:timerInterval];
    

    NSString *dateString = [dateFormat stringFromDate:confromTime];
    
    
    
    
    return dateString;
}
+ (NSString *)DeviceType
{
    NSDictionary *models = @{
                             @"i386"         :@"32-bit Simulator",
                             @"x86_64"       :@"64-bit Simulator",
                             @"iPod1,1"      :@"iPod Touch",
                             @"iPod2,1"      :@"iPod Touch",
                             @"iPod3,1"      :@"iPod Touch",
                             @"iPod4,1"      :@"iPod Touch",
                             @"iPod7,1"      :@"iPod Touch",
                             @"iPhone1,1"    :@"iPhone",
                             @"iPhone1,2"    :@"iPhone 3G",
                             @"iPhone2,1"    :@"iPhone 3GS",
                             @"iPad1,1"      :@"iPad",
                             @"iPad2,1"      :@"iPad 2",
                             @"iPad3,1"      :@"iPad",
                             @"iPhone3,1"    :@"iPhone 4",
                             @"iPhone3,3"    :@"iPhone 4",
                             @"iPhone4,1"    :@"iPhone 4S",
                             @"iPhone5,1"    :@"iPhone 5",
                             @"iPhone5,2"    :@"iPhone 5",
                             @"iPad3,4"      :@"iPad",
                             @"iPad2,5"      :@"iPad Mini",
                             @"iPhone5,3"    :@"iPhone 5c",
                             @"iPhone5,4"    :@"iPhone 5c",
                             @"iPhone6,1"    :@"iPhone 5s",
                             @"iPhone6,2"    :@"iPhone 5s",
                             @"iPad4,1"      :@"iPad Air - Wifi",
                             @"iPad4,2"      :@"iPad Air - Cellular",
                             @"iPad4,4"      :@"iPad Mini - Wifi",
                             @"iPad4,5"      :@"iPad Mini - Cellular",
                             @"iPad4,7"      :@"iPad Mini - Wifi",
                             @"iPhone7,1"    :@"iPhone 6 Plus",
                             @"iPhone7,2"    :@"iPhone 6",
                             @"iPhone8,1"    :@"iPhone 6S",
                             @"iPhone8,2"    :@"iPhone 6S Plus",
                             @"iPhone8,4"    :@"iPhone SE"
                             };
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *modelString = [models objectForKey:deviceString];
    if (!modelString) {
        modelString = deviceString;
    }
    
    return modelString;
}
/*
+ (NSString *)DeviceType
{
    NSDictionary *models = @{
                                    @"i386"         :@"32-bit Simulator",
                                    @"x86_64"       :@"64-bit Simulator",
                                    @"iPod1,1"      :@"iPod Touch",
                                    @"iPod2,1"      :@"iPod Touch Second Generation",
                                    @"iPod3,1"      :@"iPod Touch Third Generation",
                                    @"iPod4,1"      :@"iPod Touch Fourth Generation",
                                    @"iPod7,1"      :@"iPod Touch 6th Generation",
                                    @"iPhone1,1"    :@"iPhone",
                                    @"iPhone1,2"    :@"iPhone 3G",
                                    @"iPhone2,1"    :@"iPhone 3GS",
                                    @"iPad1,1"      :@"iPad",
                                    @"iPad2,1"      :@"iPad 2",
                                    @"iPad3,1"      :@"3rd Generation iPad",
                                    @"iPhone3,1"    :@"iPhone 4 (GSM)",
                                    @"iPhone3,3"    :@"iPhone 4 (CDMA/Verizon/Sprint)",
                                    @"iPhone4,1"    :@"iPhone 4S",
                                    @"iPhone5,1"    :@"iPhone 5 (model A1428, AT&T/Canada)",
                                    @"iPhone5,2"    :@"iPhone 5 (model A1429, everything else)",
                                    @"iPad3,4"      :@"4th Generation iPad",
                                    @"iPad2,5"      :@"iPad Mini",
                                    @"iPhone5,3"    :@"iPhone 5c (model A1456, A1532 | GSM)",
                                    @"iPhone5,4"    :@"iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)",
                                    @"iPhone6,1"    :@"iPhone 5s (model A1433, A1533 | GSM)",
                                    @"iPhone6,2"    :@"iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)",
                                    @"iPad4,1"      :@"5th Generation iPad (iPad Air) - Wifi",
                                    @"iPad4,2"      :@"5th Generation iPad (iPad Air) - Cellular",
                                    @"iPad4,4"      :@"2nd Generation iPad Mini - Wifi",
                                    @"iPad4,5"      :@"2nd Generation iPad Mini - Cellular",
                                    @"iPad4,7"      :@"3rd Generation iPad Mini - Wifi (model A1599)",
                                    @"iPhone7,1"    :@"iPhone 6 Plus",
                                    @"iPhone7,2"    :@"iPhone 6",
                                    @"iPhone8,1"    :@"iPhone 6S",
                                    @"iPhone8,2"    :@"iPhone 6S Plus",
                                    @"iPhone8,4"    :@"iPhone SE"
                                    };
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *modelString = [models objectForKey:deviceString];
    if (!modelString) {
        modelString = deviceString;
    }
    
    return modelString;
}
 */

+ (NSInteger)freeMemory {
    return [[SystemServices sharedServices] freeMemoryinRaw];
}

+ (NSInteger)physicalMemory {
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (long long)freeDiskSpace {
    return [[SystemServices sharedServices] longFreeDiskSpace];
}

+ (NSString*)SSIDName {
    NSDictionary *dict = [self fetchSSIDInfo];
    if (dict) {
        return [dict objectForKey:@"SSID"];
    }
    return nil;
}

+ (NSDictionary *)fetchSSIDInfo
{
    CNCopySupportedInterfaces();
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
//    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
//        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}

+ (BOOL)networkAvailable {
    return [[SystemServices sharedServices] connectedToWiFi] || [[SystemServices sharedServices] connectedToCellNetwork];
}

+ (NSString*)carrierName {
    return [[SystemServices sharedServices] carrierName];
}

+ (NSArray*)installedAppsId {
    NSMutableArray *mArray = [NSMutableArray array];
    return mArray;
}

+ (id)valueWithoutNil:(id)value{
    return value == nil?@"":value;
}

+ (BOOL)isJailbreaked {
    return [[SystemServices sharedServices] jailbroken] == NOTJAIL ? NO : YES;
}

@end
