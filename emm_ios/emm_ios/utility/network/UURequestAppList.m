//
//  UURequestAppList.m
//  emm_ios
//
//  Created by yangzigang on 16/4/7.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURequestAppList.h"

@implementation UURequestAppList

- (UURequestTestType)kindOfTest {
    return UURequestTestTypeSucceeded;
}

- (NSString*)serviceURLSuffix {
    return @"applist";
}

- (NSDictionary*)successResultForTest {
    return @{@"apps":@[
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                        @{@"name":@"指掌易",
                          @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
                          @"appId":@"com.zhizhangyi.emm",
                          @"size":@1234567,
                          @"version":@"4.6",
                          },
                     ]};
}

@end
