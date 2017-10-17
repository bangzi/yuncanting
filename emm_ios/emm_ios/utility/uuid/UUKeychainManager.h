//
//  HBKeychainManager.h
//  emm_ios
//
//  Created by uusafe on 16/3/29.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUKeychainManager : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;
@end
