//
//  UUModelAppInfo.m
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelAppInfo.h"

@implementation UUModelAppInfo

+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"icon":@"iconUrl", @"version":@"appVersion"}];
}

@end
