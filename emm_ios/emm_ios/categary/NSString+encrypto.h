//
//  NSString+encrypto.h
//  emm_ios
//
//  Created by uusafe on 16/3/28.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encrypto)
+ (NSString *)md5:(NSString *)aString;

+ (NSString *)sha1:(NSString *)aString;

+ (NSString *)sha1_base64:(NSString *)aString;

+ (NSString *)md5_base64:(NSString *)aString;

+ (NSString *)base64:(NSString *)aString;
@end
