//
//  UUProjectInfo.m
//  emm_ios
//
//  Created by yangzigang on 16/5/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUProjectInfo.h"

#ifndef UUPROJECT_URL
//#define UUPROJECT_URL @"http://192.168.126.1:8080/yuncanting"
#define UUPROJECT_URL @"http://ngrok.viakiba.cn/yuncanting"
#endif

#ifndef UUPROJECT_MOBILE_CONFIG_URL
#define UUPROJECT_MOBILE_CONFIG_URL @"https://192.168.1.231:3003/saas/filluuid?uuid=%@&companyCode=%@"
#endif

#ifndef UUSSL_CHECK_ENABLED
#define UUSSL_CHECK_ENABLED @NO
#endif

#ifndef UUSSL_CHECK_CERT_LIST
#define UUSSL_CHECK_CERT_LIST @"servercert231.cer"
#endif

/*
 网络请求使用正式版的ssl验证，当设置为YES时：UUSSL_CHECK_ENABLED,UUSSL_CHECK_CERT_LIST自动失效。
 */
#ifndef UUSSL_RELEASED
#define UUSSL_RELEASED @NO
#endif

static UUProjectInfo *__project__info__;

@implementation UUProjectInfo

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __project__info__ = [[UUProjectInfo alloc] init];
    });
    return __project__info__;
}

- (NSString*)serverURL {
    return UUPROJECT_URL;
}

- (NSString*)mobileConfigURL {
    return UUPROJECT_MOBILE_CONFIG_URL;
}

- (BOOL)sslCheckEnabled {
    return [UUSSL_CHECK_ENABLED boolValue];
}

- (BOOL)sslReleased{
    return [UUSSL_RELEASED boolValue];
}

- (NSSet<NSData*>*)pinnedCertificates {
    
    NSMutableSet *datas = [NSMutableSet set];
    NSArray *certNameList = [UUSSL_CHECK_CERT_LIST componentsSeparatedByString:@":"];
    
    for (NSString *name in certNameList) {
        NSArray *nameSplited = [name componentsSeparatedByString:@"."];
        NSString *path = nil;
        
        if (nameSplited.count > 1) {
            path = [[NSBundle mainBundle] pathForResource:nameSplited[0] ofType:nameSplited[1]];
        }
        
        if (path) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            [datas addObject:data];
        }
    }
    
    return datas;
}

@end
