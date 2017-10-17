//
//  UUGetUDID.m
//  emm_ios
//
//  Created by uusafe on 16/5/10.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUGetUDID.h"

@implementation UUGetUDID

- (void)getUDID {
    UUUDIDRequest *request = (UUUDIDRequest *)[UUUDIDRequest requestWithName:@"uuidRequest"];
    request.delegate = self;
    request.didFinishSelector = @selector(success:);
    request.didFailSelector = @selector(failed:);
    request.httpBody = @{@"companyCode":self.companyCode,
                         @"userName":self.userName,
                         @"password":self.password,
                         @"enrollId":self.enrollId
                         };
    [request start];
    
}

- (void)success:(UUUDIDRequest *)request {
    NSLog(@"UUUDIDRequest:%@",request.result);
    NSError *error;
    UUUDIDModel *model = [[UUUDIDModel alloc]initWithDictionary:request.result error:&error];
    [self.delegate getUDIDSuccess:model];
    if (_getUDIDBlock) {
        _getUDIDBlock(model);
    }
}

- (void)failed:(UUUDIDRequest *)request {
    [self.delegate getUDIDFailed];
}

@end
