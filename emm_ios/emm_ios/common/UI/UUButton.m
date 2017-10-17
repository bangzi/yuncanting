//
//  UUButton.m
//
//
//  Created by yangzigang on 15/7/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UUButton.h"
#import "UIImage+ImageFromColor.h"
IB_DESIGNABLE
@implementation UUButton

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.cornerRadius) {
        self.layer.cornerRadius = self.cornerRadius;
    }
    if (self.backgroundImageColorNormal) {
        UIImage *img = [UIImage imageWithColor:self.backgroundImageColorNormal];
        [self setBackgroundImage:[img stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    }
    if (self.backgroundImageColorHighlighted) {
        UIImage *img = [UIImage imageWithColor:self.backgroundImageColorHighlighted size:CGSizeMake(3, 3)];
        [self setBackgroundImage:[img stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
    }
    
    if (self.backgroundImageColorSelected) {
        UIImage *img = [UIImage imageWithColor:self.backgroundImageColorSelected size:CGSizeMake(3, 3)];
        [self setBackgroundImage:[img stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateSelected];
    }
    
    if (self.borderWidth && self.borderColor) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = self.borderColor.CGColor;
    }
}
@end
