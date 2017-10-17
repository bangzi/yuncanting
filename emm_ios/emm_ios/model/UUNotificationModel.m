//
//  UUNotificationModel.m
//  emm_ios
//
//  Created by uusafe on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUNotificationModel.h"
@implementation UUNotificationModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"title":@"messageTitle",@"aps.alert.sound":@"messageSoundName",@"event":@"messageType",@"msg":@"messageMSG",@"aps.alert.body":@"messageBody"}];
}
-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    if (self = [super initWithDictionary:dict error:err]) {
        [self postActionOfInit:dict error:err];
    }
    return self;
}

- (void)postActionOfInit:(NSDictionary*)dict error:(NSError**)err {
    
    
    self.messageDate = [NSDate date];
    if (dict[@"event"] == [NSNumber numberWithInteger:9]) {
        self.messageTitle = @"铃声消息";
        self.messageMSG = @"你收到一段铃声";
    }
}
@end
