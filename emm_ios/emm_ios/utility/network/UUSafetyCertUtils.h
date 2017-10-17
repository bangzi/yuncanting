//
//  UUSafetyCertUtils.h
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUSafetyCertUtils : NSObject

/*
  生成请求签名
  @param appKey 服务器提供的app key
  @param secret 服务器提供的密钥
  @param params 服务器接口请求的参数列表
 
  @return 根据算法生成的sha1加密字符串
 */
+ (NSString*)signWithAppKey:(NSString*)appKey secret:(NSString*)secret params:(NSDictionary*)params;

@end
