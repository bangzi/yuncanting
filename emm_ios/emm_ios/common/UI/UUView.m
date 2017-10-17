//
//  SHView.m
//  Diagnosis
//
//  Created by Yang Zigang on 15/1/26.
//  Copyright (c) 2015年 Shenhuang Tech. All rights reserved.
//

#import "UUView.h"

@implementation UUView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.borderWidth && self.borderColor) {
        self.layer.borderWidth = [self.borderWidth floatValue];
        self.layer.borderColor = self.borderColor.CGColor;
    }
    if (self.cornerRadius) {
        self.layer.cornerRadius = [self.cornerRadius floatValue];
        self.layer.masksToBounds = YES;
    }
}

@end
