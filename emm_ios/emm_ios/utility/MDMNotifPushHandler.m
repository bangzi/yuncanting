//
//  MDMNotifPushHandler.m
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "MDMNotifPushHandler.h"
#import "DeviceInfo.h"
#import "UURequestCMDReport.h"
#import "UULocalPersistenceUtil.h"
#import "BaseHeader.h"
#import "UIUtils.h"
#import "MDMUtils.h"
#import "UUID.h"

@implementation MDMNotifPushHandler{
    UIBackgroundTaskIdentifier backgroundUpdateTask;
}

- (void)handleEraseEMM:(UUNotiPushModel *)model{
    
    NSLog(@"%s, erase emm data...", __FUNCTION__);

    [self eraseEMM:model event:NotifPushStateDevEraseEMM data:@{@"executeResult": @(YES),
                                                                @"uuid":[UUID uuid]}];

    [UIUtils dialogWithTitle:@"提示" message:@"设备已被擦除！"];
}

- (void)handleDeviceDelete:(UUNotiPushModel *)model{
    NSLog(@"%s, delete device...", __FUNCTION__);

//    [self handleEraseEMM:model];
    [self eraseEMM:model event:NotifPushStateDevDelete data:@{@"executeResult": @(YES),
                                                              @"uuid":[UUID uuid]}];
    
    NSMutableString *reasonStr = [NSMutableString string];
    
    if (model.tips) {
        [reasonStr appendString:@"原因："];
        [reasonStr appendString:model.tips];
    }
    
    [UIUtils dialogWithTitle:@"提示" message:[NSString stringWithFormat:@"设备已被删除！%@", model.tips==nil?@"":reasonStr]];
}

- (void)eraseEMM:(UUNotiPushModel*)model event:(NotifPushState)state data:(NSDictionary*)data{
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self beginBackgroundUpdateTask];
    }

    UURequestCMDReport *request = (UURequestCMDReport *)[UURequest requestWithName:@"cmdReport"];
    request.delegate = self;
    request.token = [UULocalPersistenceUtil sharedInstance].sessionToken;
    request.companyCode = [UULocalPersistenceUtil sharedInstance].loginCompanyCode;
    
    [UULocalPersistenceUtil handleEraseData];
    
    request.event = state;
    request.data = data;
    request.didFinishSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    [request start];
}

//设备名称(xuming's ipad)，型号(iPad 2, 32G, MC770CH)，OS版本，是否越狱，存储容量，电源状态
- (void)handleDeviceUpdate:(UUNotiPushModel *)model{
    
    NSLog(@"%s, device updating...", __FUNCTION__);

    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self beginBackgroundUpdateTask];
    }
    
    UURequest *request = [UURequest requestWithName:@"devUpdate"];
    request.delegate = self;
    request.didFinishSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    [request start];
}

- (void)handleLocationUpdate:(UUNotiPushModel *)model{
}

- (void)handleAppRule:(UUNotiPushAppRuleModel *)model{
    
    NSLog(@"%s, app rule updating...", __FUNCTION__);

    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self beginBackgroundUpdateTask];
    }

    [UULocalPersistenceUtil setObject:model.toDictionary forKey:MDMKeyAppRule];

    NSArray *installeds = [DeviceInfo installedAppsId];
    //黑名单处理
    NSDictionary *blackParams = [self handleAppBlackList:model.blackList installed:installeds];
    //白名单处理
    NSDictionary *whiteParams = [self handleAppWhiteList:model.whiteList installed:installeds];
    //必装处理
    NSDictionary *mustParams = [self handleAppMustList:model.mustList installed:installeds];
    
    UURequest *request = [UURequest requestWithName:@"appRule"];
    request.parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"black":blackParams,
                                                                         @"white":whiteParams,
                                                                         @"must":mustParams}];
    request.delegate = self;
    request.didFinishSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    [request start];

}

- (void)handleDeviceLost:(UUNotiPushModel *)model{
    [UULocalPersistenceUtil setBool:YES forKey:MDMKeyIsDevHadBeenLost];
    
//    [self cmdReport:NotifPushStateDevLost data:@{@"executeResult":@(YES)}];
}

- (void)handleDeviceFound:(UUNotiPushModel *)model{
    [UULocalPersistenceUtil setBool:NO forKey:MDMKeyIsDevHadBeenLost];
//    [self cmdReport:NotifPushStateDevFound data:@{@"executeResult":@(YES)}];
}

- (void)handleCheckProfile:(UUNotiPushModel *)model{
    NSError *error = nil;
    if(MDMProfileStatusNotInstalled == [MDMUtils rootProfileStatus:&error]){
        [self eraseEMM:model event:NotifPushStateDevEraseEMM data:@{@"executeResult":@(YES),
                                                                     @"uuid":[UUID uuid]}];
        
        [UIUtils dialogWithTitle:@"提示" message:@"\"Root profile\"不存在，请重新登录！"];
    }
    
#if DEBUG
    if (error) {
        NSLog(@"%s, %@", __FUNCTION__, error);
    }
#endif
}

- (void)cmdReport:(NotifPushState)event data:(NSDictionary*)data{
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self beginBackgroundUpdateTask];
    }

    UURequestCMDReport *request = (UURequestCMDReport *)[UURequest requestWithName:@"cmdReport"];
    request.delegate = self;
    request.event = event;
    request.data = data;
    request.didFinishSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    [request start];
}


- (void) beginBackgroundUpdateTask{
    backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void) endBackgroundUpdateTask{
    [[UIApplication sharedApplication] endBackgroundTask:backgroundUpdateTask];
    backgroundUpdateTask = UIBackgroundTaskInvalid;
}

#pragma mark 黑白名单、必装应用处理。并返回需要上报到服务端的处理结果

- (NSDictionary*)handleAppBlackList:(NSArray*)blackList installed:(NSArray*)installedApps{
    //检测出本地安装的黑名单中的应用
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId IN %@", installedApps];
    NSArray *installedBlackApp = [blackList filteredArrayUsingPredicate:predicate];
    
//    NSLog(@"%@", [installedBlackApp description]);
    
    int i = 0;
    
    for(UUModelAppInfo *appInfo in installedBlackApp){
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        
        localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5 + i * 2];
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        localNotif.alertTitle = @"通知";
        localNotif.alertBody = [NSString stringWithFormat:@"安装非法应用%@", appInfo.name];
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        i++;
    }
    return @{};
}

- (NSDictionary*)handleAppWhiteList:(NSArray*)whiteList installed:(NSArray*)installedApps{
    //检测本地未安装的白名单应用，以及其他已经安装的应用
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(appId IN %@)", installedApps];
    NSArray *notInstalledWhiteApp = [whiteList filteredArrayUsingPredicate:predicate];
    NSLog(@"检测本地未安装的白名单应用: %@", [notInstalledWhiteApp description]);
    
    
    return @{};
}

- (NSDictionary*)handleAppMustList:(NSArray*)mustList installed:(NSArray*)installedApps{
    //检测本地未安装的必装应用
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(appId IN %@)", installedApps];
    NSArray *notInstalledMustApp = [mustList filteredArrayUsingPredicate:predicate];
    NSLog(@"检测本地未安装的必装应用: %@", [notInstalledMustApp description]);

    return @{};
}


#pragma mark UURequest 请求的响应协议实现
- (void)requestFinished:(UURequest*)request{
    NSLog(@"%s, %@", __FUNCTION__, request.result);
    //处理请求的响应结果
    if (backgroundUpdateTask != UIBackgroundTaskInvalid) {
        [self endBackgroundUpdateTask];
    }
    
    if (_completedBlock) {
        _completedBlock();
    }

}

- (void)requestFailed:(UURequest*)request{
    NSLog(@"%s, %@", __FUNCTION__, request.result);
    //请求失败处理
    if (backgroundUpdateTask != UIBackgroundTaskInvalid) {
        [self endBackgroundUpdateTask];
    }

    if (_completedBlock) {
        _completedBlock();
    }

}
@end
