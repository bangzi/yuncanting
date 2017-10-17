//
//  MDMNotifPushParser.h
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MDMNotifPushHandler.h"

#define NOTIF_POST(name, obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]
#define NOTIF_POST_USERINFO(name, obj, userinfo) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:userinfo]

//UIKIT_EXTERN NSString *const MDMEraseEMMNotification;
//UIKIT_EXTERN NSString *const MDMDeviceUpdateNotification;
//UIKIT_EXTERN NSString *const MDMLocationUpdateNotification;
//UIKIT_EXTERN NSString *const MDMAppRuleNotification;
//UIKIT_EXTERN NSString *const MDMDeviceLostNotification;

//content-available: 1
@interface MDMNotifPushParser : NSObject
- (BOOL)didReceiveRemoteNotification:(NSDictionary*)userinfo completed:(void (^)(void))block;
@end
