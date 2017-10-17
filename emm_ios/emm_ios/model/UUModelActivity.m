//
//  UUModelActivity.m
//  emm_ios
//
//  Created by uusafe on 16/4/7.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelActivity.h"

@implementation UUModelActivity
+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"status.code":@"code",@"status.message":@"message",@"status.uuid":@"uuid"}];
}

- (void)postActionOfInit:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
}

- (void)setCodeWithNSNumber:(NSNumber *)number {
    NSLog(@"%@",number);
    self.code = [number integerValue];
    self.message = [[self infoMessage] objectForKey:number];
}

- (NSString *)message {
    return [[self infoMessage] objectForKey:[NSNumber numberWithInteger:self.code]];
}

- (NSDictionary *)infoMessage
{
    return @{
             [NSNumber numberWithInteger:0]:@"注册失败",
             [NSNumber numberWithInteger:1]:@"注册成功",
             [NSNumber numberWithInteger:2]:@"平台错误",
             [NSNumber numberWithInteger:3]:@"设备类型错误",
             [NSNumber numberWithInteger:4]:@"设备系统版本不支持",
             [NSNumber numberWithInteger:5]:@"设备已越狱",
             [NSNumber numberWithInteger:6]:@"设备归属错误",
             [NSNumber numberWithInteger:7]:@"设备名称错误",
             [NSNumber numberWithInteger:8]:@"设备SID错误",
             [NSNumber numberWithInteger:9]:@"设备MAC地址错误",
             [NSNumber numberWithInteger:-3]:@"公司标志号非法"
             };
}
@end
