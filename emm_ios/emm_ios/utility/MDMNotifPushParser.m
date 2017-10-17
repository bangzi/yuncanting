//
//  MDMNotifPushParser.m
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "MDMNotifPushParser.h"
#import "UUNotiPushModel.h"
#import "UUNotiPushAppRuleModel.h"
#import "MDMNotifPushUtils.h"
#import "UULocalPersistenceUtil.h"



// NSString *const MDMEraseEMMNotification = @"__MDMEraseEMMNotification";
// NSString *const MDMDeviceUpdateNotification  = @"__MDMDeviceUpdateNotification";
// NSString *const MDMLocationUpdateNotification = @"__MDMLocationUpdateNotification";
// NSString *const MDMAppRuleNotification = @"__MDMAppRuleNotification";
// NSString *const MDMDeviceLostNotification = @"__MDMDeviceLostNotification";

@interface MDMNotifPushParser ()
@property (nonatomic, strong, getter=getHandler) MDMNotifPushHandler *handler;

@end
@implementation MDMNotifPushParser

- (MDMNotifPushHandler*)getHandler{
    if (!_handler) {
        _handler = [MDMNotifPushHandler new];
    }
    return _handler;
}

- (BOOL)didReceiveRemoteNotification:(NSDictionary *)userinfo completed:(void (^)(void))block{
    BOOL ret = YES;
    
#if DEBUG
    NSLog(@"%s, %@", __FUNCTION__, userinfo);
#endif
    
    self.handler.completedBlock = [block copy];
    
    //推送信息解析
    NSError *error;
    UUNotiPushModel *model = [[UUNotiPushModel alloc] initWithDictionary:userinfo error:&error];
    
    if (!error) {
        switch ((NotifPushState)model.event) {
            case NotifPushStateDevUpdate:
            {
                [self.handler handleDeviceUpdate:model];
                break;
            }
            case NotifPushStateDevEraseEMM:
            {
                [self.handler handleEraseEMM:model];
                [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusErased];
                break;
            }
            case NotifPushStateDevDelete:
            {
                [self.handler handleDeviceDelete:model];
                [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusDeleted];
                break;
            }
            case NotifPushStateDevLost:
            {
                [self.handler handleDeviceLost:model];
                [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusDeviceLost];
                break;
            }
            case NotifPushStateDevFound:
            {
                [self.handler handleDeviceFound:model];
                [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusDeviceFound];
                break;
            }
            case NotifPushStateAppRule:
            {
                
                UUNotiPushAppRuleModel *ruleModel = [[UUNotiPushAppRuleModel alloc] initWithDictionary:userinfo error:&error];
                
                if (!error) {
                    [self.handler handleAppRule:ruleModel];
                }else{
                    NSLog(@"%s  %@", __FUNCTION__, error);
                    if (block) {
                        block();
                    }
                }
                
                break;
            }
            case NotifPushStateLocationUpdate:
            {
                
                [self.handler handleLocationUpdate:model];
                break;
            }
            case NotifPushStateCheckProfile:
            {
                [self.handler handleCheckProfile:model];
                break;
            }
            default:
            {
                ret = NO;
                break;
            }
                
        }//end switch
        
    }else{
        NSLog(@"%s  %@", __FUNCTION__, error);
        ret = NO;
    }
    
    if (ret) {
        NOTIF_POST_USERINFO(MDMStateChangedNotification, model, @{MDMCurrentSate:@(model.event)});
    }else if (block){
        block();
    }
    
    return ret;
}


@end
