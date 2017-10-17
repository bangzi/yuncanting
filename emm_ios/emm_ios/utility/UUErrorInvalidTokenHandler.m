//
//  UUErrorInvalidTokenHandler.m
//  emm_ios
//
//  Created by maqj on 4/29/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUErrorInvalidTokenHandler.h"
#import "MDMNotifPushUtils.h"
#import "UIUtils.h"
#import "UULocalPersistenceUtil.h"
#import "BaseHeader.h"
#import "UUNotiPushModel.h"

@implementation UUErrorInvalidTokenHandler

- (void)handle:(UUErrorHandler *)error{
    NSLog(@"%s, %@",__FUNCTION__, error);
//    //直接调用通知的处理模块，来模拟数据擦除命令。
//    [[MDMNotifPushUtils shared] handlePushNotification:@{@"event":@(NotifPushStateDevEraseEMM)} completed:nil];
//    
//    [UIUtils dialogWithTitle:@"提示" message:@"Token 失效，请重新登录！"];
    NSString *name = [UULocalPersistenceUtil sharedInstance].loginUserName;
    NSString *pwd = [UULocalPersistenceUtil sharedInstance].loginPassword;
    NSString *securityId = [UULocalPersistenceUtil sharedInstance].securityId;
    NSString *companyCode = [UULocalPersistenceUtil sharedInstance].loginCompanyCode;

    /*
     当重新登录参数不全时，给出重新登录提示，并跳转到登录页面。
     */
    if (!name ||
        !pwd ||
        !securityId ||
        !companyCode) {
        [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusLogin];
        NOTIF_POST_USERINFO(MDMStateChangedNotification, nil, nil);
        [UIUtils dialogWithTitle:@"提示" message:[NSString stringWithFormat:@"token失效，请重新登录！"]];
        NSLog(@"%s, 自动重新登录失败，参数错误。", __FUNCTION__);
        return;
    }
    //重新登录，并获取新的token
    UURequestLogin *request = (UURequestLogin*)[UURequest requestWithName:@"login"];
    request.delegate = self;
    request.didFinishSelector = @selector(requestFinished:);
    request.didFailSelector = @selector(requestFailed:);
    [request start];
}

#pragma mark UURequest 请求的响应协议实现
- (void)requestFinished:(UURequest*)request{
    NSLog(@"%s, %@", __FUNCTION__, request.result);
    //处理请求的响应结果
    NSError *error;
    UUModelLogin *loginModel = [[UUModelLogin alloc] initWithDictionary:request.result error:&error];
    
    if (error) {
        NSLog(@"%s, %@", __FUNCTION__, error);
        
        if (_failureBlock) {
            _failureBlock(request.error);
        }
    }else{
        switch (loginModel.code) {
            case LoginStatusDeviceActivitied:{
                [UULocalPersistenceUtil sharedInstance].sessionToken = loginModel.token;
                [UULocalPersistenceUtil sharedInstance].clientPassword = loginModel.clientPassword;
                [UULocalPersistenceUtil sharedInstance].clientUserName = loginModel.userName;
                [UULocalPersistenceUtil sharedInstance].sessionUUID = loginModel.uuid;
                [UULocalPersistenceUtil sharedInstance].encryptKey = loginModel.encryptKey;
                [UULocalPersistenceUtil sharedInstance].encryptType = loginModel.encryptType;
                [UULocalPersistenceUtil sharedInstance].dataTransmissionInterval = loginModel.dataTransmissionInterval;
                
                if (_successBlock) {
                    _successBlock(request.result);
                }

                break;
            }
            case LoginStatusSuccessButNoRegister:
            case LoginStatusUserNameOrPasswdError:
            case LoginStatusDeviceRegistered:
            case LoginStatusDevicePendingWiped:
            case LoginStatusDeviceWiped:
            case LoginStatusDeviceLosted:
            case LoginStatusDeviceDeleted:
            case LoginStatusServiceError:
            case LoginStatusTokenInvalid:
            case LoginStatusForbidRegister:
            case LoginStatusForbidActivity:
            case LoginStatusRegisterUserBeyond:
            case LoginStatusUserDisable:{
                [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusLogin];
                NOTIF_POST_USERINFO(MDMStateChangedNotification, nil, nil);
                [UIUtils dialogWithTitle:@"提示" message:[NSString stringWithFormat:@"%@，请重新登录！", loginModel.message]];
                
                if (_failureBlock) {
                    _failureBlock([NSError errorWithDomain:@"Login failed." code:-1 userInfo:[loginModel toDictionary]]);
                }

                break;
            }
        }//end switch
    }//end else
    
}

- (void)requestFailed:(UURequest*)request{
    NSLog(@"%s, %@", __FUNCTION__, request.result);

    if (_failureBlock) {
        _failureBlock(request.error);
    }
}


@end
