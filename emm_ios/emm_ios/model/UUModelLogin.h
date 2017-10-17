//
//  UUModelLogin.h
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
typedef NS_ENUM(NSInteger,LoginStatus){
    LoginStatusUserNameOrPasswdError = 10,
    LoginStatusSuccessButNoRegister = 12,
    LoginStatusDeviceRegistered = 13,
    LoginStatusDeviceActivitied,
    LoginStatusDeviceWiped,
    LoginStatusDevicePendingWiped,
    LoginStatusDeviceLosted,
    LoginStatusDeviceDeleted,
    LoginStatusServiceError,
    LoginStatusTokenInvalid,
    LoginStatusForbidRegister = 101,
    LoginStatusForbidActivity = 102,
    LoginStatusRegisterUserBeyond = 103,
    LoginStatusUserDisable = 104
};
@interface UUModelLogin : UUModel
@property (nonatomic,strong) NSString<Optional> *message;
@property (nonatomic,assign) LoginStatus code;
@property (nonatomic,strong) NSString<Optional> *userName;
@property (nonatomic,strong) NSString<Optional> *userId;
@property (nonatomic,strong) NSString<Optional> *clientPassword;
@property (nonatomic,strong) NSString<Optional> *dataTransmissionInterval;
@property (nonatomic,strong) NSString<Optional> *token;
@property (nonatomic,strong) NSString<Optional> *encryptKey;
@property (nonatomic,strong) NSString<Optional> *encryptType;
@property (nonatomic,strong) NSString<Optional> *uuid;

//@property (nonatomic,strong)UUModelLoginStatus *status;

//@property (nonatomic, assign) int code;
//@property (nonatomic, strong) NSString<Optional> *userName;
//@property (nonatomic, strong) NSString<Optional> *userId;
//@property (nonatomic, strong) NSString *message;
//@property (nonatomic, strong) NSString<Optional> *token;
//@property (nonatomic, strong) NSString<Ignore> *errorMessage;

@end
