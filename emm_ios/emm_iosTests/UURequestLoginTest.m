//
//  UURequestLoginTest.m
//  emm_ios
//
//  Created by maqj on 5/4/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UUErrorHandler.h"
#import "UURequestLogin.h"

@interface UURequestLoginTest : XCTestCase

@end

@implementation UURequestLoginTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    UUErrorHandler *handler = [UUErrorHandler handlerWithDomain:nil code:-2 userInfo:nil];
    
    BOOL ret = [handler handleSuccess:^(id response) {
        //重新开始本次请求。
//        [self requestHttpURLWithPost];
        NSLog(@"%@", response);
        
    } failure:^(NSError *error) {
        NSLog(@"%s, %@", __FUNCTION__, error);
        
    }];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
