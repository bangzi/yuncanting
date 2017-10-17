//
//  HBUUID.h
//  emm_ios
//
//  Created by uusafe on 16/3/29.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUID : NSObject
+ (NSString *)uuid;

+ (void)saveUUID:(NSString *)uuid;

+ (void)deleteUUID;
@end
