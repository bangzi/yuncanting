//
//  UUModelVersionUpdate.m
//  emm_ios
//
//  Created by 冯海邦 on 16/4/20.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelVersionUpdate.h"

@implementation UUModelVersionUpdate

+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"url":@"appUrl", @"version":@"appVersion"}];
}

@end
