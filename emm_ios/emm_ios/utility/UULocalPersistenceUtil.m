//
//  UULocalPersistenceUtil.m
//  emm_ios
//
//  Created by maqj on 4/19/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UULocalPersistenceUtil.h"
#import "UUPasswordTool.h"
#import "BaseHeader.h"
#import "UUDatabaseManager.h"
#import "UUID.h"
#import "UURegisterRequest.h"
#import "UULoginRequest.h"
#import "MDMUtils.h"
NSString *const MDMKeyIsDevHadBeenLost = @"__MDMKeyIsDevHadBeenLost";
NSString *const MDMKeyIsErasedEMM = @"__MDMKeyIsErasedEMM";
//NSString *const MDMKeyAppBlackList = @"__MDMKeyAppBlackList";
//NSString *const MDMKeyAppWhiteList = @"__MDMKeyAppWhiteList";
//NSString *const MDMKeyAppMustList = @"__MDMKeyAppMustList";
NSString *const MDMKeyAppRule = @"__MDMKeyAppRule";

NSString *const MDMKeyAppStatus = @"__MDMKeyAppStatus";

NSString *const SessionToken = @"__SessionToken";
NSString *const SessionUUID = @"__SessionUUID";
NSString *const SessionEncryptKey = @"__SessionEncryptKey";
NSString *const SessionClientUserId = @"__SessionClientUserId";
NSString *const SessionClientUserName = @"__SessionClientUserName";
NSString *const SessionClientPassword = @"__SessionClientPassword";
NSString *const SessionEncryptType = @"__SessionEncryptType";
NSString *const DataTransmissionInterval = @"__DataTransmissionInterval";
NSString *const LoginCompanyCode = @"__LoginCompanyCode";
NSString *const PushToken  = @"__PushToken";
NSString *const LoginURL = @"__LoginURL";
NSString *const RegisterURL = @"__RegisterURL";
NSString *const BaseURL = @"__BaseURL";
NSString *const DeviceUDID = @"__DeviceUDID";
static UULocalPersistenceUtil *__local_persistence_util;

@implementation UULocalPersistenceUtil

+ (UULocalPersistenceUtil*)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __local_persistence_util = [[UULocalPersistenceUtil alloc] init];
    });
    return __local_persistence_util;
}

- (void)setAppStatus:(UUAppStatus)appStatus {
    [[NSUserDefaults standardUserDefaults] setInteger:appStatus forKey:MDMKeyAppStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UUAppStatus)appStatus {
    return (UUAppStatus)[[NSUserDefaults standardUserDefaults] integerForKey:MDMKeyAppStatus];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+ (id)objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveUserName:(NSString *)userName password:(NSString *)password {
    [UUPasswordTool saveUserName:userName passWord:password];
}

#pragma mark -- 登录使用的信息
- (void)setLoginCompanyCode:(NSString *)loginCompanyCode {
    if (_loginCompanyCode == loginCompanyCode) {
        return;
    }
    _loginCompanyCode = loginCompanyCode;
    [self setObject:loginCompanyCode forKey:LoginCompanyCode];
}

- (NSString *)loginCompanyCode {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:LoginCompanyCode];
}

- (void)setLoginUserName:(NSString *)loginUserName {
    if (_loginUserName == loginUserName) {
        return;
    }
    _loginUserName = loginUserName;
    [UUPasswordTool saveUserName:loginUserName];
}

- (NSString *)loginUserName {
    return [UUPasswordTool readUserName];
}
- (void)setLoginPassword:(NSString *)loginPassword {
    if (_loginPassword == loginPassword) {
        return;
    }
    _loginPassword = loginPassword;
    [UUPasswordTool savePassword:loginPassword];
}

- (NSString *)loginPassword {
    return [UUPasswordTool readPassWord];
}

- (void)setPushToken:(NSString *)pushToken {
    if (_pushToken == pushToken) {
        return;
    }
    _pushToken = pushToken;
    [self setObject:pushToken forKey:PushToken];
}

- (NSString *)pushToken {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:PushToken];
}

- (void)setBaseURL:(NSString *)baseURL {
    if (_baseURL == baseURL) {
        return;
    }
    _baseURL = baseURL;
    [self setObject:baseURL forKey:BaseURL];
}

- (NSString *)baseURL {
 return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:BaseURL];
}

- (void)setDeviceUDID:(NSString *)deviceUDID {
    if (_deviceUDID == deviceUDID) {
        return;
    }
    _deviceUDID  = deviceUDID;
    [self setObject:deviceUDID forKey:DeviceUDID];
}

- (NSString *)deviceUDID {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:DeviceUDID];
}
#pragma mark 登录返回后的信息，存储与取出

- (void)setSessionToken:(NSString *)sessionToken {
    if (_sessionToken == sessionToken) {
        
        return;
    }
    _sessionToken = sessionToken;
    [self setObject:sessionToken forKey:SessionToken];
}

- (NSString *)sessionToken {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SessionToken];
}

- (void)setSessionUUID:(NSString *)sessionUUID {
    if (_sessionUUID == sessionUUID) {
        return;
    }
    _sessionUUID = sessionUUID;
    [self setObject:sessionUUID forKey:SessionUUID];
}

- (NSString *)sessionUUID {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SessionUUID];
}

- (void)setEncryptKey:(NSString *)encryptKey {
    if (_encryptKey == encryptKey) {
        return;
    }
    _encryptKey = encryptKey;
    [self setObject:encryptKey forKey:SessionEncryptKey];
}

- (NSString *)encryptKey {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SessionEncryptKey];
}

- (void)setClientUserId:(NSString *)clientUserId {
    if (_clientUserId == clientUserId) {
        return;
    }
    _clientUserId = clientUserId;
    [self setObject:clientUserId forKey:SessionClientUserId];
}

- (NSString *)clientUserId {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SessionClientUserId];
}

- (void)setClientUserName:(NSString *)clientUserName {
    if (_clientUserName == clientUserName) {
        return;
    }
    _clientUserName = clientUserName;
    [self setObject:clientUserName forKey:SessionClientUserName];
}

- (void)setClientPassword:(NSString *)clientPassword {
    if (_clientPassword == clientPassword) {
        return;
    }
    _clientPassword = clientPassword;
    [self setObject:clientPassword forKey:SessionClientPassword];
}

- (NSString *)clientPassword {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SessionClientPassword];
}

- (void)setDataTransmissionInterval:(NSString *)dataTransmissionInterval {
    if (_dataTransmissionInterval == dataTransmissionInterval) {
        return;
    }
    _dataTransmissionInterval = dataTransmissionInterval;
    [self setObject:dataTransmissionInterval forKey:DataTransmissionInterval];
}

- (NSString *)dataTransmissionInterval {
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:DataTransmissionInterval];
}

- (void)setSecurityId:(NSString *)securityId {
    [UUID saveUUID:securityId];
}
- (NSString *)securityId {
    return [UUID uuid];
}

- (void)setObject:(id)value forKey:(NSString *)aKey {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:aKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)readUserName {
    return [UUPasswordTool readUserName];
}

+ (void)handleEraseData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionUUID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionEncryptKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionEncryptType];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionClientUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionClientUserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SessionClientPassword];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:DataTransmissionInterval];
    [[UUDatabaseManager shareInstance]deleteAllData];
    [UUPasswordTool deleteUsernamePassword];
}

+ (void)setMyServerToken:(NSString *)token forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveLoginModel:(id)model forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UUModelLogin *)loginModelForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    UUModelLogin *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

+ (BOOL)isFirstLaunched {
    NSError *error;
    if (![UULocalPersistenceUtil sharedInstance].loginPassword) {
        return YES;
    }
    if (![UULocalPersistenceUtil sharedInstance].sessionToken) {
        return YES;
    }
    return NO;
    
}
@end
