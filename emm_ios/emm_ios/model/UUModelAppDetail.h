//
//  UUModelAppDetail.h
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"

@interface UUModelAppDetail : UUModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *appDescription;

@end
