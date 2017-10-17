//
//  UULoginTextField.m
//  emm_ios
//
//  Created by uusafe on 16/5/11.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUTextField.h"
IB_DESIGNABLE
@implementation UUTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
//    [placeholder addAttribute:NSForegroundColorAttributeName value:self.placeholderColor range:NSMakeRange(0, self.placeholder.length)];
    self.attributedPlaceholder = placeholder;
    self.tintColor = [UIColor whiteColor];
}

@end
