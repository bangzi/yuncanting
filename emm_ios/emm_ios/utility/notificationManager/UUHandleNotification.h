//
//  UUHandleNotification.h
//  emm_ios
//
//  Created by uusafe on 16/4/15.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NSString* (^tokenBlock)(void);
@interface UUHandleNotification : NSObject
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)NSDictionary *dict;
- (BOOL)handlePushNotification:(NSDictionary *)dict state:(UIApplicationState)state viewController:(UIViewController *)viewController managerObjectContext:(NSManagedObjectContext *)managerObjectContext;

- (BOOL)handleAppDescribePushNotification:(NSDictionary *)dict state:(UIApplicationState)state viewController:(UIViewController *)viewController managerObjectContext:(NSManagedObjectContext *)managerObjectContext;

- (void)handlePushToken:(NSString *)token viewController:(UIViewController *)viewController;

- (void)viewControllerPushToken:(UIViewController *)viewController token:(tokenBlock)block;

- (void)handleIsInstallPushNotification:(NSDictionary *)dict;

- (void)handlePushAppStoreViewWithController:(UIViewController *)viewController;

@end
