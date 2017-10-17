//
//  UUModelLogin.m
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelLogin.h"

@implementation UUModelLogin
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.code forKey:@"code"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.clientPassword forKey:@"clientPassword"];
    [aCoder encodeObject:self.dataTransmissionInterval forKey:@"dataTransmissionInterval"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.encryptKey forKey:@"encryptKey"];
    [aCoder encodeObject:self.encryptType forKey:@"encryptType"];
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.code = [aDecoder decodeIntegerForKey:@"code"];
    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.clientPassword = [aDecoder decodeObjectForKey:@"clientPassword"];
    self.dataTransmissionInterval = [aDecoder decodeObjectForKey:@"dataTransmissionInterval"];
    self.token = [aDecoder decodeObjectForKey:@"token"];
    self.encryptKey = [aDecoder decodeObjectForKey:@"encryptKey"];
    self.encryptType = [aDecoder decodeObjectForKey:@"encryptType"];
    self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
    return self;
}
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"status.code":@"code",@"status.message":@"message",@"status.userName":@"userName",@"status.userId":@"userId",@"status.dataTransmissionInterval":@"dataTransmissionInterval",@"status.clientPassword":@"clientPassword",@"token":@"token",@"status.encryptKey":@"encryptKey",@"status.encryptType":@"encryptType",@"status.uuid":@"uuid"}];
}
- (void)setCodeWithNSNumber:(NSNumber*)number {
    self.code = [number integerValue];
    //TODO: self.errorMessage = @"错误信息";
   // NSDictionary *dict = [self infoMessage];
    self.message = [[self infoMessage] objectForKey:number];
}
- (NSString *)message {
    return [[self infoMessage] objectForKey:[NSNumber numberWithInteger:self.code]];
}
- (NSDictionary *)infoMessage
{
    return @{
             [NSNumber numberWithInteger:12]:@"设备登陆成功但未注册",
             [NSNumber numberWithInteger:10]:@"用户名或密码错误",
             [NSNumber numberWithInteger:13]:@"设备已注册",
             [NSNumber numberWithInteger:14]:@"设备已激活",
             [NSNumber numberWithInteger:15]:@"设备已擦除",
             [NSNumber numberWithInteger:16]:@"设备待擦除",
             [NSNumber numberWithInteger:17]:@"设备已丢失",
             [NSNumber numberWithInteger:18]:@"设备待删除",
             [NSNumber numberWithInteger:19]:@"已删除",
             [NSNumber numberWithInteger:-1]:@"服务端错误 ",
             [NSNumber numberWithInteger:-2]:@"token 失效"
             };
}
@end
