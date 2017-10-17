//
//  UURequest.h
//
//
//  Created by yangzigang on 4/29/14.
//  Copyright (c) 2014  All rights reserved.
//

#import <Foundation/Foundation.h>

@class UURequest;
@protocol UURequestDelegate <NSObject>

@optional
//- (void)requestDidFinished:(UURequest*)request;
//- (void) requestDidFailed:(UURequest*)request;

@end

typedef enum {
    UURequestTestTypeNone,
    UURequestTestTypeFailed,
    UURequestTestTypeSucceeded,
    UURequestTestTypeExternal,
}UURequestTestType;

typedef enum {
    UURequestMethodGet,
    UURequestMethodPost,
}UURequestMethod;

@interface UURequest : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) NSDictionary *httpBody;
@property (nonatomic, assign) int responseStatus;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) SEL didFinishSelector;
@property (nonatomic, assign) SEL didFailSelector;
@property (nonatomic, strong) NSArray *urlRewriteParameters;
@property (nonatomic, strong) NSString *csfTokenCookie;
@property (nonatomic, strong) NSDictionary *extraHeaders;

+ (UURequest*)requestWithName:(NSString*)requestName;
+ (void)setBaseURLString:(NSString*)baseURLString;
- (UURequestTestType)kindOfTest;
- (NSDictionary*)successResultForTest;
- (NSError*)errorResultForTest;
- (NSTimeInterval)timeToDelay;
- (void)start;
- (BOOL)requestSucceeded;
- (BOOL)requireSessionId;
- (BOOL)requireUserId;
- (int)resultStatus;
- (NSString*)resultErrorMessage;

- (NSString*)baseURLString;
- (NSString*)serviceURLSuffix;

- (NSString*)sessionId;

- (UURequestMethod)requestMethod;
@end
