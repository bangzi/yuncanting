//
//  UUEnrollModel.h
//  emm_ios
//
//  Created by uusafe on 16/5/10.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
typedef NS_ENUM(NSUInteger,EnrollStatus) {
    EnrollStatusFail,
    EnrollStatusSuccess
};
@interface UUEnrollModel : UUModel

@property (nonatomic, assign) EnrollStatus  code;
@property (nonatomic, strong) NSString<Optional>  *uuid;
@end
