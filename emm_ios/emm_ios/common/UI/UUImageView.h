//
//  UUImageView.h
//  emm_ios
//
//  Created by yangzigang on 16/4/12.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUImageView : UIImageView

@property (nonatomic, strong) IBInspectable NSNumber *cornerRadius;
@property (nonatomic, strong) IBInspectable NSNumber *borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
