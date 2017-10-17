//
//  UUImageView.m
//  emm_ios
//
//  Created by yangzigang on 16/4/12.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUImageView.h"

@implementation UUImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyUI];
}

- (void)applyUI {
    if (self.cornerRadius) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = [self.cornerRadius floatValue];
    }
    if (self.borderWidth && self.borderColor) {
        self.layer.borderWidth = [self.borderWidth floatValue];
        self.layer.borderColor = self.borderColor.CGColor;
    }
}

@end
