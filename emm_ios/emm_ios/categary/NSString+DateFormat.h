//
//  NSString+DateFormat.h
//  emm_ios
//
//  Created by uusafe on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormat)
+ (NSString *)dateToString:(NSDate*)date format:(NSString *)format;
@end
