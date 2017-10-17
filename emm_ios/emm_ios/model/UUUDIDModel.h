//
//  UUUIDModel.h
//  emm_ios
//
//  Created by uusafe on 16/5/10.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
typedef NS_ENUM(NSUInteger,GetUDIDStatus) {
    GetUDIDStatusFail,
    GetUDIDStatusSuccess
};
@interface UUUDIDModel : UUModel

@property (nonatomic, assign) GetUDIDStatus  code;
@property (nonatomic, strong) NSString<Optional>  *udid;

@end
