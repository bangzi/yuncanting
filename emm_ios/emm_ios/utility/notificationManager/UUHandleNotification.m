//
//  UUHandleNotification.m
//  emm_ios
//
//  Created by uusafe on 16/4/15.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUHandleNotification.h"
#import "UUDatabaseManager.h"
#import "UUNotificationModel.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "UUNotification.h"
#import "UUPlayAudio.h"
//#import "UUAppDescribe.h"
//#import "UUAppDescribeModel.h"
#import "UUAppInstallModel.h"
#import "JSONModelLib.h"
#import "UURequestMyApps.h"

@implementation UUHandleNotification
- (BOOL)handlePushNotification:(NSDictionary *)dict state:(UIApplicationState)state viewController:(UIViewController *)viewController managerObjectContext:(NSManagedObjectContext *)managerObjectContext
{
    NSError *error;
    UUNotificationModel *model = [[UUNotificationModel alloc]initWithDictionary:dict error:&error];
    if (model.messageType.integerValue != 2 || model.messageType.integerValue != 9) {
        return NO;
    }
    UUNotification *notification = [[UUDatabaseManager shareInstance] insertIntoDataSource:model];
    if (nil == notification.messageSoundName) {
        notification.messageSoundName = @"default";
    }
    ViewController *controller = (ViewController *)viewController;
//    controller.notifiaction = notification;
        switch (state) {
            case UIApplicationStateActive:
            {
                [[UUPlayAudio shareManger]play:notification.messageSoundName];
            }
                break;
            case UIApplicationStateInactive:
                
            case UIApplicationStateBackground:
            {
                
            }
                break;
        default:
                break;
     
    }
    
    return YES;
}
- (void)handlePushToken:(NSString *)token viewController:(UIViewController *)viewController
{
    ViewController *controller = (ViewController *)viewController;
   // controller.notificationToken = token;
}
- (void)viewControllerPushToken:(UIViewController *)viewController token:(tokenBlock)block
{
    ViewController *controller = (ViewController *)viewController;
  //  controller.notificationToken = block();
}

- (BOOL)handleAppDescribePushNotification:(NSDictionary *)dict state:(UIApplicationState)state viewController:(UIViewController *)viewController managerObjectContext:(NSManagedObjectContext *)managerObjectContext{
    return YES;
}

- (void)handleIsInstallPushNotification:(NSDictionary *)dict{

}

- (void)handlePushAppStoreViewWithController:(UIViewController *)viewController {
    ViewController *controller = (ViewController *)viewController;
    [controller pushAppStoreView];
}

@end
