//
//  UURequestLocationUpdate.m
//  emm_ios
//
//  Created by maqj on 4/19/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UURequestLocationUpdate.h"

@implementation UURequestLocationUpdate
- (UURequestTestType)kindOfTest{
    return UURequestTestTypeSucceeded;
}

- (NSDictionary*)successResultForTest{
    return @{@"status":@(200)};
}

@end
