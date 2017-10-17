//
//  UUPasswordTool.h
//  emm_ios
//
//  Created by uusafe on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUPasswordTool : NSObject
/**
 *  @brief 存储密码
 *
 *  @param password 密码内容
 */
+(void)saveUserName:(NSString *)username passWord:(NSString *)password;

+ (id)readUserName;
/**
 *  读取密码
 *
 *  @return 密码内容
 */
+(id)readPassWord;
/**
 *  删除数据
 */
+(void)deleteUsernamePassword;

+ (void)savePassword:(NSString *)password;

+ (void)saveUserName:(NSString *)username;
@end
