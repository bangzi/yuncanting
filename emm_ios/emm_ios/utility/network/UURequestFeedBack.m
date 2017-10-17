//
//  UURequestFeedBack.m
//  emm_ios
//
//  Created by 冯海邦 on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURequestFeedBack.h"

@implementation UURequestFeedBack


- (UURequestTestType)kindOfTest{
    return UURequestTestTypeSucceeded;//UURequestTestTypeFailed
}

- (NSDictionary*)successResultForTest {
    return @{@"apps":@[
                     @{@"name":@"请求成功",
                       @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                       @"appId":@"com.zhizhangyi.emm",
                       @"size":@1234567,
                       @"version":@"4.6",
                       }
                     ]};
}

- (NSError*)errorResultForTest {
    return nil;
}

@end
