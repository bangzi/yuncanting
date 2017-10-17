//
//  UUErrorHandler.h
//  emm_ios
//
//  Created by maqj on 4/29/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define UUHandleError(D, C, U)  {UUErrorHandler *handler = [UUErrorHandler handlerWithDomain:(D) code:(C) userInfo:(U)];[handler handle];}


@class UUErrorHandler;

@protocol UUErrorHandlerDelegate <NSObject>

@required
@property (nonatomic, copy) void(^successBlock)(id response);
@property (nonatomic, copy) void(^failureBlock)(NSError *error);

- (void)handle:(UUErrorHandler*)error;

@end

typedef NS_ENUM(NSInteger, UUError) {
    UUErrorNone,
    UUErrorInvalidCompanyId = -3,
    UUErrorInvalidToken = -2,
    UUErrorServerInternalError = -1,
    
};

@interface UUErrorHandler : NSError
@property (nonatomic, readonly, getter=handlerList) NSMutableDictionary *handlerList;

+ (UUErrorHandler*)handlerWithDomain:(NSString*)domain code:(NSInteger)code userInfo:(NSDictionary*)dict;

+ (void)addHandler:(id<UUErrorHandlerDelegate>)handler withErrorCode:(NSInteger)code;

/*
 @return 当找到对应code的处理器return YES，相反则return NO
 */
- (BOOL)handleSuccess:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
