//
//  UUKeychainManager.m
//  emm_ios
//
//  Created by uusafe on 16/3/29.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUKeychainManager.h"

@implementation UUKeychainManager
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge_transfer id)kSecClassGenericPassword,kSecClass,service,kSecAttrService,service,kSecAttrAccount,kSecAttrAccessibleAfterFirstUnlock,kSecAttrAccessible, nil];
}
+ (void)save:(NSString *)service data:(id)data
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained  CFDictionaryRef)keychainQuery, NULL);
}
+ (id)load:(NSString *)service
{
    id ret = nil;
    
    NSMutableDictionary *keychainQiery = [self getKeychainQuery:service];
    
    [keychainQiery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    
    [keychainQiery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQiery,(CFTypeRef *)&keyData) == noErr ) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", service, exception);
        } @finally {
            
        }
        
    }
    return ret;
    
    
}
+ (void)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}
@end
