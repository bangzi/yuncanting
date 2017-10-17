//
//  UURequestMyApps.m
//  emm_ios
//
//  Created by 冯海邦 on 16/5/9.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURequestMyApps.h"

@implementation UURequestMyApps

- (UURequestTestType)kindOfTest{
    return UURequestTestTypeNone;
}

- (UURequestMethod)requestMethod{
    return UURequestMethodPost;
}

- (NSString *)serviceURLSuffix{
    return @"/ios/isAppInstall";
}

- (NSString *)baseURLString{
    return @"https://192.168.1.128:3009";
}


@end
