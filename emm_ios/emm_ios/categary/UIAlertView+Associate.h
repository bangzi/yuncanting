//
//  UIAlertView+Associate.h
//  emm_ios
//
//  Created by uusafe on 16/4/15.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUNotification.h"
#import "UUNotificationModel.h"
@interface UIAlertView (Associate)
- (void)setNotificationModel:(UUNotificationModel *)model;
- (UUNotificationModel *)notificationModel;

- (void)setNotification:(UUNotification *)notification;

- (UUNotification *)notification;
@end
