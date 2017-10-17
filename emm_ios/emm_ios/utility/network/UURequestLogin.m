//
//  UURequestLogin.m
//  emm_ios
//
//  Created by maqj on 5/3/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UURequestLogin.h"
#import "BaseHeader.h"
#import "UUID.h"
#import "UULocalPersistenceUtil.h"
#import "UUPasswordTool.h"
#import "UUProjectInfo.h"

@implementation UURequestLogin
- (UURequestTestType)kindOfTest{
    return UURequestTestTypeNone;
}

- (NSDictionary*)successResultForTest{
    return @{@"status":@(200)};
}

- (UURequestMethod)requestMethod{
    return UURequestMethodPost;
}

- (NSString*)baseURLString {
    return [[UUProjectInfo sharedInstance] serverURL];
}

- (NSString*)serviceURLSuffix {
    return @"/userInfo";
}

@end
