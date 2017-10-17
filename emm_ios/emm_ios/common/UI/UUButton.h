//
//  UUButton.h
//
//
//  Created by yangzigang on 15/7/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@property (nonatomic, strong) IBInspectable UIColor *backgroundImageColorNormal;
@property (nonatomic, strong) IBInspectable UIColor *backgroundImageColorHighlighted;
@property (nonatomic, strong) IBInspectable UIColor *backgroundImageColorSelected;

@end
