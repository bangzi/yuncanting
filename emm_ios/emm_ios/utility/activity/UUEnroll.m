//
//  UUEnroll.m
//  emm_ios
//
//  Created by uusafe on 16/5/9.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUEnroll.h"
#import "UUEnrollRequest.h"

@implementation UUEnroll

- (void)enrollForUUID {
    UUEnrollRequest *request = (UUEnrollRequest *)[UUEnrollRequest requestWithName:@"enrollRequest"];
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

- (void)success:(UUEnrollRequest *)request {
    NSError *error;
    UUEnrollModel *model = [[UUEnrollModel alloc]initWithDictionary:request.result error:&error];
    [self.delegate enrollSuccess:model];
    if (_statusBlock) {
        _statusBlock(model);
    }
}

- (void)failed:(UUEnrollRequest *)request {
    [self.delegate enrollFailed];
}

@end
