//
//  MDMNotifPushUtils.h
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDMNotifPushParser.h"
#import "UUNotiPushModel.h"
#import "UUNotiPushAppRuleModel.h"

/*
 当收到服务端推送命令时会发出此通知，且在userinfo中包含当前命令状态值：MDMCurrentSate，取值为enum NotifPushEvent。
 */
UIKIT_EXTERN NSString *const MDMStateChangedNotification;

UIKIT_EXTERN NSString *const MDMCurrentSate;

typedef NS_ENUM(NSInteger, NotifPushState) {
    NotifPushStateNone = 0,
    NotifPushStateDevUpdate = 1,
    NotifPushStateDevEraseEMM = 5,
    NotifPushStateDevDelete = 6,
    NotifPushStateDevLost = 7,
    NotifPushStateDevFound = 8,
    //应用黑白名单，必装应用
    NotifPushStateAppRule = 20,
    //设备定位
    NotifPushStateLocationUpdate = 10,
    //检测本地root profile是否安装
    NotifPushStateCheckProfile = 11
};

@interface MDMNotifPushUtils : NSObject
+(instancetype)shared;

- (BOOL)handlePushNotification:(NSDictionary*)userinfo completed:(void(^)(void))block;

#pragma mark 获取当前MDM状态信息，包括：是否标记丢失、应用黑白名单/必装应用规则、是否已经擦除企业数据。
- (BOOL)isDevHadBeenLost;
- (BOOL)isErasedEMM;
- (UUNotiPushAppRuleModel*)appRuleWitherror:(NSError**)error;

- (void)resetEraseEMMState;
- (void)resetHadBennLostState;
@end
