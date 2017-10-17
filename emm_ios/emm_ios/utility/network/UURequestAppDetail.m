//
//  UURequestAppDetail.m
//  emm_ios
//
//  Created by yangzigang on 16/4/11.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UURequestAppDetail.h"

@implementation UURequestAppDetail

- (UURequestTestType)kindOfTest {
    return UURequestTestTypeSucceeded;
}

- (NSDictionary*)successResultForTest {
    return @{
             @"name":@"指掌易",
             @"icon":@"http://pic.qiantucdn.com/58pic/11/88/81/04c58PIC3MI.png",
             @"appId":@"com.zhizhangyi.emm",
             @"size":@1234567,
             @"version":@"4.6",
             @"pubDate":@"2016-01-06",
             @"description":@"选择有道词典，就是选择与5亿语言学习用户一起享受有道为您提供的周到服务。作为一款英语、日语、韩语、法语免费全能查词翻译软件，有道词典在多年来致力于为用户提供更优质的翻译服务，针对Mac平台特性，我们特别推出全新的版本，更符合Mac用户翻译使用习惯。发布多年以来，成为Mac系统下必备的词典软件，在同类软件排行位居前列。"
             };
}

@end
