//
//  UUErrorHandler.m
//  emm_ios
//
//  Created by maqj on 4/29/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUErrorHandler.h"
#import "UUErrorInvalidTokenHandler.h"

static NSMutableDictionary *handlerList;

static NSDictionary *errorCodeList;

@interface UUErrorHandler ()<UUErrorHandlerDelegate>


@end

@implementation UUErrorHandler

+ (void)load{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{

        NSString *path = [[NSBundle mainBundle] pathForResource:@"errorcodes" ofType:@"plist"];
        
        if (path) {
            errorCodeList = [NSDictionary dictionaryWithContentsOfFile:path];
        }
        
        handlerList = [NSMutableDictionary dictionary];
        handlerList[@(UUErrorInvalidToken)] = [UUErrorInvalidTokenHandler new];
//        [UUErrorHandler addHandler:[UUErrorHandler handlerWithDomain:errorCodeList[[@(UUErrorServerInternalError) stringValue]] code:UUErrorServerInternalError userInfo:nil] withErrorCode:UUErrorServerInternalError];
//        [UUErrorHandler addHandler:[UUErrorHandler handlerWithDomain:errorCodeList[[@(UUErrorInvalidCompanyId) stringValue]] code:UUErrorInvalidCompanyId userInfo:nil] withErrorCode:UUErrorInvalidCompanyId];
    });
}

- (NSMutableDictionary*)handlerList{
    return handlerList;
}



+ (UUErrorHandler*)handlerWithDomain:(NSString*)domain code:(NSInteger)code userInfo:(NSDictionary*)dict{
    if (!domain) {
        NSString *domain = errorCodeList[[@(code) stringValue]];
        if (!domain) {
            domain = @"错误信息需要后续处理";
        }
        return [super errorWithDomain:domain code:code userInfo:nil];
    }
    
    return [super errorWithDomain:domain code:code userInfo:dict];
}

+ (void)addHandler:(id<UUErrorHandlerDelegate>)handler withErrorCode:(NSInteger)code{
    @synchronized (self) {
        handlerList[@(code)] = handler;
    }
}

- (BOOL)handleSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure{
    id<UUErrorHandlerDelegate> handler = handlerList[@(self.code)];
    if ([handler respondsToSelector:@selector(handle:)]) {
        handler.successBlock = success;
        handler.failureBlock = failure;
        
        [handler handle:self];
        return YES;
    }
    return NO;
}

- (void)handle:(UUErrorHandler*)error{
    NSLog(@"%@", self);
}



@end
