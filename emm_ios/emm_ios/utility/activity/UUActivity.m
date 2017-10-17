//
//  UUActivity.m
//  emm_ios
//
//  Created by uusafe on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUActivity.h"
#import "NSString+encrypto.h"
#import "UUID.h"
#import "BaseHeader.h"
#import "DeviceInfo.h"
#import "UUModelLogin.h"
#import "MBProgressHUD.h"
#import "UURegisterRequest.h"
#import "UULocalPersistenceUtil.h"

@implementation UUActivity
- (void)activityDevice
{
 //   NSString *baseUrl = [BASEURL stringByAppendingString:@"/api/device/reg"];
//   NSString *baseUrl = @"http://192.168.1.120:3002/uusafe/api/device/reg";
    
    UURegisterRequest *request = (UURegisterRequest *)[UURegisterRequest requestWithName:@"registerDevice"];
    request.delegate = self;
    request.didFinishSelector = @selector(success:);
    request.didFailSelector = @selector(failed:);
    [request start];
}

- (void)success:(UURegisterRequest *)request
{
    NSLog(@"----%@",request.result);
  //  NSString *str = [[NSString alloc]initWithData:request.result encoding:NSUTF8StringEncoding];
  //  NSLog(@"activity---%@",str);
    NSError *error;
    UUModelActivity *model = [[UUModelActivity alloc] initWithDictionary:request.result error:&error];
    [self.delegate activitySuccess:model];
    
//    NSLog(@"UUModelActivity--%@",error);
    if (self.status) {
        self.status(model);
    }
    
    //增加token失效处理。
    //UUHandleError(nil, model.code, nil);
}

- (void)failed:(UURegisterRequest *)request
{
    NSLog(@"error--%@",request);
    [self.delegate activityFailed];
}
@end
