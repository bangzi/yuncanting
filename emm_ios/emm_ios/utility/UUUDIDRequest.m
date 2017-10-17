//
//  UUUDIDRequest.m
//  emm_ios
//
//  Created by uusafe on 16/5/10.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUUDIDRequest.h"

@implementation UUUDIDRequest

- (UURequestMethod)requestMethod {
    return UURequestMethodPost;
}

- (NSString*)serviceURLSuffix {
    return @"/api/device/getUDID";
}

@end
