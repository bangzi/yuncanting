//
//  NSString+DateFormat.m
//  emm_ios
//
//  Created by uusafe on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "NSString+DateFormat.h"

@implementation NSString (DateFormat)
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;
}
@end
