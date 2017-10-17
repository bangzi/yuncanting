//
//  UUModelDeviceDetail.m
//  emm_ios
//
//  Created by yangzigang on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModelDeviceDetail.h"

@implementation UUModelDeviceDetail

+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"edge":@"edgeInsetsString", @"type":@"detailType"}];
}

- (UIEdgeInsets)edgeInsets {
    return UIEdgeInsetsFromString(self.edgeInsetsString);
}

- (void)setDetailTypeWithNSString:(NSString*)detailTypeString {
    if ([detailTypeString isEqualToString:@"separator"]) {
        self.detailType = UUModelDeviceDetailTypeSeparator;
    }
    if ([detailTypeString isEqualToString:@"title"]) {
        self.detailType = UUModelDeviceDetailTypeTitle;
    }
    if ([detailTypeString isEqualToString:@"info"]) {
        self.detailType = UUModelDeviceDetailTypeInfo;
    }
}

- (NSAttributedString*)attributedText {
    switch (self.detailType) {
        case UUModelDeviceDetailTypeTitle:
            return [self titleForAttributedString:self.text];
            break;
        case UUModelDeviceDetailTypeInfo:
            return [self grayTextForAttributedString:self.text];
        default:
            break;
    }
    return nil;
}

- (CGFloat)heightForWidth:(CGFloat)width {
    switch (self.detailType) {
        case UUModelDeviceDetailTypeSeparator:
            return self.edgeInsets.top + self.edgeInsets.bottom + 1;
            break;
        case UUModelDeviceDetailTypeTitle:
            return 28;
            break;
        case UUModelDeviceDetailTypeInfo:
            return 18;
            break;
        default:
            break;
    }
    return 0;
}

- (NSAttributedString*)titleForAttributedString:(NSString*)string {
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1.0]}];
}

- (NSAttributedString*)grayTextForAttributedString:(NSString*)string {
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor colorWithRed:135.0/255 green:135.0/255 blue:135.0/255 alpha:1.0]}];
}

@end
