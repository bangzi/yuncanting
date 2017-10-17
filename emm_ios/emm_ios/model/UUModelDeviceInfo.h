//
//  UUModelDeviceInfo.h
//  emm_ios
//
//  Created by yangzigang on 16/4/12.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
#import <UIKit/UIKit.h>

@interface UUModelDeviceInfo : UUModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSNumber<Optional> *showRightArrow;
@property (nonatomic, strong) NSString<Optional> *rightTitle;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *action;
@property (nonatomic, strong) NSString<Optional> *extraInfo;

@end
