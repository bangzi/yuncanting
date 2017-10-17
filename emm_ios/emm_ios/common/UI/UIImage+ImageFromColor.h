//
//  UIImage+ImageFromColor.h
//  
//
//  Created by Yang Zigang on 15/1/21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageFromColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
