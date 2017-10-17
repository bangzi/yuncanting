//
//  UUNotificationSetting.m
//  emm_ios
//
//  Created by uusafe on 16/4/28.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUNotificationSetting.h"
#import "BaseHeader.h"
#import <UIKit/UIKit.h>
@implementation UUNotificationSetting
+ (BOOL)isAllowedNotification
{
    if (SYSTEM_VERSION_GREATER_THAN(@"8.0")) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
       if (UIUserNotificationTypeNone != setting.types) {
            return YES;
       }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}
@end
