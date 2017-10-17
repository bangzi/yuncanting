//
//  UUModel.h
//  emm_ios
//
//  Created by yangzigang on 16/4/6.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "JSONModel.h"

@interface UUModel : JSONModel

- (void)postActionOfInit:(NSDictionary*)dict error:(NSError**)err;

@end
