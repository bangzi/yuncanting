//
//  UUTest.h
//  emm_ios
//
//  Created by yangzigang on 16/4/5.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UURequest.h"
#import "JSONModelLib.h"

@interface UUTest : NSObject <UURequestDelegate>

- (void)testNetwork;
- (void)testJSONModel;
- (void)testDeviceInfo;
- (void)testDataBase;

@end
