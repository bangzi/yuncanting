//
//  HBUUID.m
//  emm_ios
//
//  Created by uusafe on 16/3/29.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUID.h"
#import "UUKeychainManager.h"
static NSString * const KEY_IN_KEYCHAIN = @"com.uusafe.ios.emm.uuid";
@implementation UUID
+ (NSString*)uuid
{
    NSString *uuid = [UUKeychainManager load:KEY_IN_KEYCHAIN];
    if (!uuid || uuid.length == 0) {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        
        uuid = [NSString stringWithFormat:@"%@",uuidString];
        
        [self saveUUID:uuid];
        
        CFRelease(puuid);
        
        CFRelease(uuidString);
    }
    return uuid;
}
+ (void)deleteUUID
{
    [UUKeychainManager delete:KEY_IN_KEYCHAIN];
}

+ (void)saveUUID:(NSString *)uuid
{
    if (uuid && uuid.length > 0) {
        [UUKeychainManager save: KEY_IN_KEYCHAIN data:uuid];
    }
}
@end
