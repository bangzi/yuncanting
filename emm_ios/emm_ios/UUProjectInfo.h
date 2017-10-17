//
//  UUProjectInfo.h
//  emm_ios
//
//  Created by yangzigang on 16/5/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUProjectInfo : NSObject

+ (instancetype)sharedInstance;

- (NSString*)serverURL;
- (NSString*)mobileConfigURL;
- (BOOL)sslCheckEnabled;
- (BOOL)sslReleased;
- (NSSet<NSData*>*)pinnedCertificates;

@end
