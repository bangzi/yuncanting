//
//  UUNotiPushModel.m
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUNotiPushModel.h"

NSString *const MDMStateChangedNotification = @"__MDMStateChangedNotification";
NSString *const MDMCurrentSate = @"__MDMCurrentSate";


@implementation UUNotiPushModel
+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"event":@"event",
                                 @"reason":@"tips"
                                 }];
}
@end
