//
//  MDMUtils.m
//  emm_ios
//
//  Created by maqj on 4/25/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "MDMUtils.h"

@implementation MDMUtils
+ (MDMProfileStatus) parseCA:(NSData *)certData error:(NSError**)error{
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)(certData));
    
    if (!cert) {
        if (error) {
            *error = [[NSError alloc] initWithDomain:@"The is not a valid DER-encoded X.509 certificate." code:-1 userInfo:nil];
        }
        return MDMProfileStatusError;
    }
    
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    OSStatus err = SecTrustCreateWithCertificates((__bridge CFArrayRef)[NSArray arrayWithObject:(__bridge id)cert], policy, &trust);
    
    SecTrustResultType trustResult = -1;
    err = SecTrustEvaluate(trust, &trustResult);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(cert);
    
    if (trustResult == kSecTrustResultUnspecified) {
        // Profile is installed.
        return MDMProfileStatusInstalled;
    }else{
        // Profile not installed.
        return MDMProfileStatusNotInstalled;
    }
}

+ (MDMProfileStatus) profileLocalStatus:(NSString *)name ofType:(NSString*)ext error:(NSError**)error{
    
    NSString *certPath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    
    NSLog(@"certificate path: %@", certPath);
    if (!certPath) {
        NSLog(@"Certificate path null.");
        if (error) {
            *error = [[NSError alloc] initWithDomain:@"Local certificate not found." code:-1 userInfo:nil];
        }
        return MDMProfileStatusError;
    }
    
    NSData *certData = [NSData dataWithContentsOfFile:certPath];
    
    return [self parseCA:certData error:error];
}

+ (MDMProfileStatus) rootProfileStatus:(NSError**)error{

    MDMProfileStatus status = [MDMUtils profileLocalStatus:@"certest" ofType:@"mine" error:error];
    
    NSLog(@"%s, Profile %@, error = %@", __FUNCTION__, (status==MDMProfileStatusNotInstalled?@"not installed.":@"installed."), error==nil?@"":*error);
    
    return status;
}

@end
