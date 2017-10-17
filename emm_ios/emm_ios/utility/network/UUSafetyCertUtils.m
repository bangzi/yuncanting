//
//  UUSafetyCertUtils.m
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUSafetyCertUtils.h"
#import "NSString+encrypto.h"

@implementation UUSafetyCertUtils
+ (NSString*)signWithAppKey:(NSString*)appKey secret:(NSString*)secret params:(NSDictionary*)params{
    NSMutableString *stringBuf = [NSMutableString stringWithString:appKey];
    
    NSArray *allKeys = [params keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for(NSString *key in allKeys){
        [stringBuf appendString:key];
        [stringBuf appendString:params[key]];
    }
    
    [stringBuf appendString:secret];
    
    return [NSString sha1:stringBuf];
}


@end
