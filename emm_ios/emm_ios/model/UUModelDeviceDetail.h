//
//  UUModelDeviceDetail.h
//  emm_ios
//
//  Created by yangzigang on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UUModelDeviceDetailType) {
    UUModelDeviceDetailTypeSeparator,
    UUModelDeviceDetailTypeTitle,
    UUModelDeviceDetailTypeInfo,
};

@interface UUModelDeviceDetail : UUModel

@property (nonatomic, strong) NSString *cell;
@property (nonatomic, assign) NSString<Optional> *edgeInsetsString;
@property (nonatomic, strong) NSString<Optional> *text;
@property (nonatomic, assign) UUModelDeviceDetailType detailType;

- (UIEdgeInsets)edgeInsets;
- (NSAttributedString*)attributedText;
- (CGFloat)heightForWidth:(CGFloat)width;

@end
