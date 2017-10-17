//
//  UUAppInstallModel.m
//  emm_ios
//
//  Created by 冯海邦 on 16/5/5.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUAppInstallModel.h"

@implementation UUAppInstallModel

+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"identifier":@"identifier",
                                 @"uuid":@"uuid",
                                 @"commandUUID":@"commandUUID",
                                 @"event":@"event"
                                 }];
}

@end
