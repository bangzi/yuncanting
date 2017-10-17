//
//  UUErrorInvalidTokenHandler.h
//  emm_ios
//
//  Created by maqj on 4/29/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUErrorHandler.h"
#import "UURequestLogin.h"

@interface UUErrorInvalidTokenHandler : NSObject<UUErrorHandlerDelegate, UURequestDelegate>

@property (nonatomic, copy) void(^successBlock)(id response);
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

@end
