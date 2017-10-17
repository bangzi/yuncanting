//
//  UUPasswordTool.m
//  emm_ios
//
//  Created by uusafe on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUPasswordTool.h"
#import "UUKeychainManager.h"
@implementation UUPasswordTool
static NSString * const KEY_IN_KEYCHAIN = @"com.uusafe.emm.ios.usernamepassword";
static NSString * const KEY_PASSWORD = @"password";
static NSString * const KEY_USERNAME = @"username";
static NSString * const USERNAME_IN_KEYCHAIN = @"com.uusafe.emm.ios.username";
static NSString * const PASSWORD_IN_KEYCHAIN = @"com.uusafe.emm.ios.password";

+(void)saveUserName:(NSString *)username passWord:(NSString *)password
{
    [self saveUserName:username];
    [self savePassword:password];
   // [UUKeychainManager save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
    
    
}
+ (void)saveUserName:(NSString *)username
{
    NSMutableDictionary *usernameKVPairs = [NSMutableDictionary dictionary];
    [usernameKVPairs setObject:username forKey:KEY_USERNAME];
    [UUKeychainManager save:USERNAME_IN_KEYCHAIN data:usernameKVPairs];

}
+ (void)savePassword:(NSString *)password
{
    NSMutableDictionary *passwordKVPairs = [NSMutableDictionary dictionary];
    [passwordKVPairs setObject:password forKey:KEY_PASSWORD];
    [UUKeychainManager save:PASSWORD_IN_KEYCHAIN data:passwordKVPairs];
}
+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[UUKeychainManager load:PASSWORD_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}
+ (id)readUserName
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[UUKeychainManager load:USERNAME_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_USERNAME];
}
+(void)deleteUsernamePassword
{
    [UUKeychainManager delete:PASSWORD_IN_KEYCHAIN];
    [UUKeychainManager delete:USERNAME_IN_KEYCHAIN];
}
@end
