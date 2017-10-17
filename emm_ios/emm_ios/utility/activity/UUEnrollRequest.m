//
//  UUEnrollRequest.m
//  emm_ios
//
//  Created by uusafe on 16/5/9.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUEnrollRequest.h"

@implementation UUEnrollRequest

- (UURequestMethod)requestMethod {
    return UURequestMethodPost;
}

- (NSString*)serviceURLSuffix {
    return @"/api/device/getUUID";
}

@end
