//
//  UUNotiPushAppRuleModel.h
//  emm_ios
//
//  Created by maqj on 4/19/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUModel.h"
#import "UUModelAppInfo.h"

@interface UUNotiPushAppRuleModel : UUModel
@property (nonatomic, strong) NSArray<UUModelAppInfo> *blackList;
@property (nonatomic, strong) NSArray<UUModelAppInfo> *whiteList;
@property (nonatomic, strong) NSArray<UUModelAppInfo> *mustList;
@end
