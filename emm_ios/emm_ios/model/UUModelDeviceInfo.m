//
//  UUModelDeviceInfo.m
//  emm_ios
//
//  Created by yangzigang on 16/4/12.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelDeviceInfo.h"

@implementation UUModelDeviceInfo

+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"rightArrow":@"showRightArrow"}];
}

- (void)setIconWithNSString:(NSString*)icon {
    UIImage *image = [UIImage imageNamed:icon];
    self.icon = image;
}

@end
