//
//  UUAppConntentAvailableModel.m
//  emm_ios
//
//  Created by 冯海邦 on 16/5/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUAppConntentAvailableModel.h"

@implementation UUAppConntentAvailableModel

+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"content-available":@"contentAvailable",
                                 }];
}

@end
