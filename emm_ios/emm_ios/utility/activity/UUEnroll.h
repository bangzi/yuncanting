//
//  UUEnroll.h
//  emm_ios
//
//  Created by uusafe on 16/5/9.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUEnrollModel.h"

@protocol EnrollDelegate <NSObject>

- (void)enrollSuccess:(UUEnrollModel *)model;
- (void)enrollFailed;

@end

typedef void (^EnrollStatusBlock)(UUEnrollModel *model);
@interface UUEnroll : NSObject

@property (nonatomic, strong) NSString *companyCode;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *enrollId;
@property (nonatomic, assign) id<EnrollDelegate> delegate;

@property (nonatomic, copy) EnrollStatusBlock statusBlock;

- (void)enrollForUUID;

@end
