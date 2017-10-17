//
//  UUActivity.h
//  emm_ios
//
//  Created by uusafe on 16/4/19.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUModelActivity.h"

@protocol ActivityDelegate <NSObject>

- (void)activitySuccess:(UUModelActivity *)model;
- (void)activityFailed;

@end

typedef void (^RegisterStatusBlock)(UUModelActivity *model);
/**
 *  请求注册类，注册状态返回给login
 */
@interface UUActivity : NSObject

@property (nonatomic,strong) NSString *userName;

@property (nonatomic,strong) NSString *passWord;

@property (nonatomic,strong) NSDictionary *parameters;

@property (nonatomic,strong) NSString *companyCode;

@property (nonatomic,copy)   RegisterStatusBlock status;

@property (nonatomic,strong) NSString *token;

@property (nonatomic,assign) id<ActivityDelegate> delegate;
//从苹果服务器获取推送token
@property (nonatomic,strong) NSString *pushToken;

- (void)activityDevice;
@end
