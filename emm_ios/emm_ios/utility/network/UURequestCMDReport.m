//
//  UURequestCMDReport.m
//  emm_ios
//
//  Created by maqj on 4/27/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UURequestCMDReport.h"
#import "BaseHeader.h"
#import "UULocalPersistenceUtil.h"

@implementation UURequestCMDReport
- (UURequestTestType)kindOfTest{
    return UURequestTestTypeNone;
}

- (NSDictionary*)successResultForTest{
    return @{@"status":@(200)};
}

- (UURequestMethod)requestMethod{
    return UURequestMethodPost;
}

//- (NSString*)baseURLString {
//    return BASEURL;
//}

- (NSString*)serviceURLSuffix {
    return @"/api/command/report";
}

- (NSDictionary*)httpBody{
    
    _token = [self token];
    _companyCode = [self companyCode];
    
    return @{@"sign":@"test_sign",
             @"token": _token,
             @"type":@"device",
             @"command":@(_event),
             @"companyCode": _companyCode,
             @"data":_data==nil?@{@"status":@(200)}:_data};
}

- (NSString*)companyCode{
    if (_companyCode) {
        return _companyCode;
    }
    _companyCode = [UULocalPersistenceUtil sharedInstance].loginCompanyCode;
    return _companyCode == nil?@"":_companyCode;
}

- (NSString*)token{
    if (_token) {
        return _token;
    }
    _token = [UULocalPersistenceUtil sharedInstance].sessionToken;
    return _token == nil?@"":_token;
}

@end
