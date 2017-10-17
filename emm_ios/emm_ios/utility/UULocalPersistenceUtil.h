//
//  UULocalPersistenceUtil.h
//  emm_ios
//
//  Created by maqj on 4/19/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UUModelLogin.h"
UIKIT_EXTERN NSString *const MDMKeyIsDevHadBeenLost;
UIKIT_EXTERN NSString *const MDMKeyIsErasedEMM;
//UIKIT_EXTERN NSString *const MDMKeyAppBlackList;
//UIKIT_EXTERN NSString *const MDMKeyAppWhiteList;
//UIKIT_EXTERN NSString *const MDMKeyAppMustList;
UIKIT_EXTERN NSString *const MDMKeyAppRule;

typedef enum {
    //需要登录
    UUAppStatusLogin,
    //注册设备
    UUAppStatusRegisterDevice,
    //检查设备是否已经注册
    UUAppStatusRegistrationStateCheck,
    //正常
    UUAppStatusNormal,
    //设备被擦除
    UUAppStatusErased,
    //设备被删除
    UUAppStatusDeleted,
    //用户密码已经被重置
    UUAppStatusPasswordChanged,
    //用户已被禁止
    UUAppStatusForbiddenUser,
    //当前设备已经被标记丢失
    UUAppStatusDeviceLost,
    //当前设备标记为已经找回
    UUAppStatusDeviceFound
}UUAppStatus;



@interface UULocalPersistenceUtil : NSObject
{
    NSString *_loginCompanyCode;
    NSString *_loginUserName;
    NSString *_loginPassword;
    NSString *_sessionToken;
    NSString *_sessionUUID;
    NSString *_clientUserName;
    NSString *_clientPassword;
    NSString *_encryptKey;
    NSString *_encryptType;
    NSString *_clientUserId;
    NSString *_dataTransmissionInterval;
    //从苹果服务器获取推送token
    NSString *_pushToken;
    NSString *_baseURL;
    NSString *_deviceUDID;
    
}
@property (nonatomic, strong) NSString *baseURL;

@property (nonatomic, strong) NSString *loginCompanyCode;
//用户登录的用户名
@property (nonatomic, strong) NSString *loginUserName;
//用户登录的密码
@property (nonatomic, strong) NSString *loginPassword;
@property (nonatomic, strong) NSString *securityId;
@property (nonatomic, strong) NSString *deviceUDID;

//登录成功后返回的信息
@property (nonatomic, assign) LoginStatus code;
@property (nonatomic, strong) NSString *sessionUUID;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSString *clientUserName;
@property (nonatomic, strong) NSString *clientUserId;
@property (nonatomic, strong) NSString *clientPassword;
@property (nonatomic, strong) NSString *dataTransmissionInterval;
@property (nonatomic, strong) NSString *encryptKey;
@property (nonatomic, strong) NSString *encryptType;
@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, strong) NSString *pushToken;

- (void)setAppStatus:(UUAppStatus)appStatus;
- (UUAppStatus)appStatus;

+ (UULocalPersistenceUtil*)sharedInstance;

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
+ (BOOL)boolForKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

- (void)saveUserName:(NSString *)userName password:(NSString *)password;
+ (void)setMyServerToken:(NSString *)token forKey:(NSString *)key;

+ (void)handleEraseData;
//loginmodel 存储
+ (void)saveLoginModel:(id)model forKey:(NSString *)key;
//loginmodel 取出
+ (UUModelLogin *)loginModelForKey:(NSString *)key;

+ (BOOL)isFirstLaunched;
@end
