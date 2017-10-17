//
//  MDMNotifPushUtils.m
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "MDMNotifPushUtils.h"
#import "UULocalPersistenceUtil.h"

@implementation MDMNotifPushUtils{
    MDMNotifPushParser *_parser;
}

- (void)setParser:(MDMNotifPushParser*)parser{
    _parser = parser;
}

+ (instancetype)shared{
    static MDMNotifPushUtils *utils;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        utils = [MDMNotifPushUtils new];
        [utils setParser:[MDMNotifPushParser new]];
    });
    return utils;
}

- (BOOL)handlePushNotification:(NSDictionary *)userinfo completed:(void (^)(void))block{
    return [_parser didReceiveRemoteNotification:userinfo completed:block];
}


- (BOOL)isDevHadBeenLost{
    return [UULocalPersistenceUtil boolForKey:MDMKeyIsDevHadBeenLost];
}

- (BOOL)isErasedEMM{
    return [UULocalPersistenceUtil boolForKey:MDMKeyIsErasedEMM];
}

- (UUNotiPushAppRuleModel*)appRuleWitherror:(NSError *__autoreleasing *)error{
    NSDictionary *dic = [UULocalPersistenceUtil objectForKey:MDMKeyAppRule];
    
    return [[UUNotiPushAppRuleModel alloc] initWithDictionary:dic error:error];
}

- (void)resetEraseEMMState{
    [UULocalPersistenceUtil setBool:NO forKey:MDMKeyIsErasedEMM];
}

- (void)resetHadBennLostState{
    [UULocalPersistenceUtil setBool:NO forKey:MDMKeyIsDevHadBeenLost];
}

@end
