//
//  UUGetUDID.h
//  emm_ios
//
//  Created by uusafe on 16/5/10.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUUDIDRequest.h"
#import "UUUDIDModel.h"

@protocol GetUDIDDelegate <NSObject>

- (void)getUDIDSuccess:(UUUDIDModel *)model;
- (void)getUDIDFailed;

@end

typedef void (^GetUDIDBlock)(UUUDIDModel *model);
@interface UUGetUDID : NSObject

@property (nonatomic, strong) NSString *companyCode;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *enrollId;
@property (nonatomic, assign) id<GetUDIDDelegate> delegate;

@property (nonatomic, copy) GetUDIDBlock getUDIDBlock;

- (void)getUDID;

@end
