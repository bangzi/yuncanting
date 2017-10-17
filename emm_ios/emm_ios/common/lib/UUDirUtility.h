//
//  UUDirUtility.h
//  Diagnosis
//
//  Created by 杨子刚 on 15/3/20.
//  Copyright (c) 2015年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUDirUtility : NSObject

+ (NSString*)directoryOfName:(NSString*)name excludeFromiCloud:(BOOL)excludeFromiCloud;

@end
