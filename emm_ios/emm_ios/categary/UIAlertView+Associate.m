//
//  UIAlertView+Associate.m
//  emm_ios
//
//  Created by uusafe on 16/4/15.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UIAlertView+Associate.h"
#import <objc/runtime.h>
static char notificationModel;
static char notifi;
@implementation UIAlertView (Associate)
- (void)setNotificationModel:(UUNotificationModel *)model
{
    objc_setAssociatedObject(self, &notificationModel, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UUNotificationModel *)notificationModel
{
    return objc_getAssociatedObject(self, &notificationModel);
}
- (void)setNotification:(UUNotification *)notification
{
    objc_setAssociatedObject(self, &notifi, notification, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UUNotification *)notification
{
    return objc_getAssociatedObject(self, &notifi);
}
@end
