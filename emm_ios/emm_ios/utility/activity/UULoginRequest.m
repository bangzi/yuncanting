//
//  UULoginRequest.m
//  emm_ios
//
//  Created by uusafe on 16/5/4.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UULoginRequest.h"
#import "UURequest.h"
#import "BaseHeader.h"
@implementation UULoginRequest

- (UURequestMethod)requestMethod {
    return UURequestMethodPost;
}

- (NSString*)serviceURLSuffix {
    return @"/api/device/login";
}

@end
