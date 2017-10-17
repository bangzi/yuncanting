//
//  UUDirUtility.m
//  Diagnosis
//
//  Created by 杨子刚 on 15/3/20.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UUDirUtility.h"

@implementation UUDirUtility


+ (NSString*)directoryOfName:(NSString*)name excludeFromiCloud:(BOOL)excludeFromiCloud{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSAssert(array.count > 0, @"没有发现文档文件夹");
    NSString *documentPath = [array objectAtIndex:0];
    NSString *ret = [documentPath stringByAppendingFormat:@"/%@", name];
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:ret isDirectory:&isDirectory]) {
        NSAssert(isDirectory, @"%@不是文件夹", ret);
        return  ret;
    }
    NSError *err = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:ret withIntermediateDirectories:YES attributes:nil error:&err];
    if (excludeFromiCloud) {
        [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:ret]];
    }
    NSAssert(err == nil, @"%@", err);
    return ret;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]], @"file not exist %@", [URL path]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES] forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
//        C_NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
