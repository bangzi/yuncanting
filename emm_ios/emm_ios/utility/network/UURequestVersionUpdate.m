//
//  UURequestVersionUpdate.m
//  emm_ios
//
//  Created by 冯海邦 on 16/4/20.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURequestVersionUpdate.h"

@implementation UURequestVersionUpdate

- (UURequestTestType)kindOfTest{
    return UURequestTestTypeSucceeded;//UURequestTestTypeFailed
}

- (NSDictionary*)successResultForTest {
    return   @{@"url":@"http://pic.qiantucdn.com",
               @"version":@"1.8",
                       };
}

- (NSError*)errorResultForTest {
    return nil;
}

@end
