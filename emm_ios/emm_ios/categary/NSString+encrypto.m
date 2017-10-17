//
//  NSString+encrypto.m
//  emm_ios
//
//  Created by uusafe on 16/3/28.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "NSString+encrypto.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
@implementation NSString (encrypto)
+ (NSString *)md5:(NSString *)aString
{
    const char *cstr = [aString UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cstr,strlen(cstr),digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}
+ (NSString *)sha1:(NSString *)aString
{
    const char *cstr = [aString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:aString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,data.length,digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    
    return output;
}
+ (NSString *)base64:(NSString *)aString
{
    NSData *data = [aString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *output = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}
+ (NSString *)md5_base64:(NSString *)aString
{
    const char *cstr = [aString UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cstr, strlen(cstr), digest);
    
    NSData *base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    
    base64 = [GTMBase64 encodeData:base64];
    
    NSString *output = [[NSString alloc]initWithData:base64 encoding:NSUTF8StringEncoding];
    
    return output;
}

+ (NSString *)sha1_base64:(NSString *)aString
{
    const char *cstr = [aString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:aString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSData *base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    
    base64 = [GTMBase64 encodeData:base64];
    
    NSString *output = [[NSString alloc]initWithData:base64 encoding:NSUTF8StringEncoding];
    
    return output;
    
}
@end
