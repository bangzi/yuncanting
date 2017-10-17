//
//  UUModelAppInfo.h
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"

@protocol UUModelAppInfo <NSObject>
@end

@interface UUModelAppInfo : UUModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appVersion;

@end
