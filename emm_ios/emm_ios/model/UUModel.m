//
//  UUModel.m
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
#import "JSONModelClassProperty.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation UUModel

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    if (self = [super initWithDictionary:dict error:err]) {
        [self postActionOfInit:dict error:err];
    }
    return self;
}

- (void)postActionOfInit:(NSDictionary*)dict error:(NSError**)err {
    
}

@end
