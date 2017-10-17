//
//  NSString+Predicate.h
//  test
//
//  Created by uusafe on 16/3/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Predicate)
- (BOOL)isUserName;

- (BOOL)isPassword;

- (BOOL)isEmail;

- (BOOL)isUrl;

- (BOOL)isTelephone;
@end
