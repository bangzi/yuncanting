//
//  MDMUtils.h
//  emm_ios
//
//  Created by maqj on 4/25/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MDMProfileStatus) {
    MDMProfileStatusInstalled,
    MDMProfileStatusNotInstalled,
    MDMProfileStatusError
};

@interface MDMUtils : NSObject
+ (MDMProfileStatus) profileLocalStatus:(NSString *)name ofType:(NSString*)ext error:(NSError**)error;
+ (MDMProfileStatus) rootProfileStatus:(NSError**)error;
@end
