//
//  UURequest.m
//
//
//  Created by yangzigang on 4/29/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UURequest.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "UUErrorHandler.h"
#import "UULocalPersistenceUtil.h"
#import "UUProjectInfo.h"

#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code) { _Pragma("clang diagnostic push")  _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")  code;  _Pragma("clang diagnostic pop")}
//SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( return [_target performSelector:_action withObject:self] );


@interface CTimeOutRequest : AFJSONRequestSerializer

@property (nonatomic, strong) NSDictionary *extraHeaders;

@end

@implementation CTimeOutRequest

- (id)init {
    if (self = [super init]) {
        self.timeoutInterval = 20;
//        [self setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content"];
    }
    return self;
}

@end


static NSDictionary *__requestList = nil;
static NSString *__base_url;

@interface UURequest ()

@property (nonatomic, retain) NSString *className;

@end

@implementation UURequest

+ (UURequest*)requestWithName:(NSString*)requestName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *requestListPath = [[NSBundle mainBundle] pathForResource:@"RequestList" ofType:@"plist"];
        __requestList = [NSDictionary dictionaryWithContentsOfFile:requestListPath];
        NSAssert(__requestList, @"please supply correct request list file");
    });
    NSString *requestClassName = [__requestList objectForKey:requestName];
    NSAssert(requestClassName, @"request for %@ is not set", requestName);
    UURequest *request = [[NSClassFromString(requestClassName) alloc] init];
    request.className = requestClassName;
    return request;
}

+ (void)setBaseURLString:(NSString*)baseURLString {
    __base_url = baseURLString;
}

- (UURequestTestType)kindOfTest {
    return UURequestTestTypeNone;
}
- (NSDictionary*)successResultForTest {
    return nil;
}
- (NSError*)errorResultForTest {
    return nil;
}

- (NSTimeInterval)timeToDelay {
    return 2;
}

- (NSString*)baseURLString {
//    return [UULocalPersistenceUtil sharedInstance].baseURL;
    return __base_url;
    return @"http://192.168.1.212";
}

- (NSString*)serviceURLSuffix {
    return @"/";
}

- (NSString*)sessionId {
    return nil;
    return @"123123123";
}

- (BOOL)requireSessionId {
    return YES;
}
- (BOOL)requireUserId {
    return YES;
}

- (UURequestMethod)requestMethod {
    return UURequestMethodGet;
}

- (AFHTTPResponseSerializer*)serializer {
    return [AFJSONResponseSerializer serializer];
}

- (void)notifyDelegate {
    if (self.delegate && [self.delegate respondsToSelector:self.didFinishSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFinishSelector withObject:self]);
    }
}

- (void)start {
    if ([self kindOfTest] != UURequestTestTypeNone && [self kindOfTest] != UURequestTestTypeExternal) {
        [self test];
        return;
    }
    NSString *URLString = [NSString stringWithFormat:@"%@%@", [self baseURLString], [self serviceURLSuffix]];
    if (self.urlRewriteParameters && self.urlRewriteParameters.count) {
        NSString *suffix = [self.urlRewriteParameters componentsJoinedByString:@"/"];
        URLString = [URLString stringByAppendingFormat:@"/%@/", suffix];
    }
    if ([self kindOfTest] == UURequestTestTypeExternal) {
        URLString = @"http://httpbin.org/post";
    }
    if (!self.parameters) {
        self.parameters = [NSMutableDictionary dictionary];
    }
    if (![self.parameters isKindOfClass:[NSMutableDictionary class]]) {
        self.parameters = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
    }
    if (self.parameters) {
        NSArray *keys = [self.parameters allKeys];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:keys.count];
        for (int i = 0; i < keys.count; i++) {
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [self.parameters objectForKey:key];
            NSString *parameter = [NSString stringWithFormat:@"%@=%@", key, value];
            [array addObject:parameter];
        }
        
        NSString *parameters = [array componentsJoinedByString:@"&"];
        parameters = [parameters stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (parameters.length) {
            URLString = [NSString stringWithFormat:@"%@?%@", URLString, parameters];
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    CTimeOutRequest *request = [CTimeOutRequest serializer];
//    [request setAuthorizationHeaderFieldWithUsername:@"shtech" password:@"shtech2014"];
    request.extraHeaders = self.extraHeaders;
    manager.requestSerializer = request;
    manager.responseSerializer = [self serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes  setByAddingObjectsFromArray:@[@"text/html"]];

    AFSecurityPolicy *securityPolicy = nil;
    
    if ([UUProjectInfo sharedInstance].sslReleased) {
        securityPolicy = [AFSecurityPolicy defaultPolicy];
    }else if ([UUProjectInfo sharedInstance].sslCheckEnabled){
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[UUProjectInfo sharedInstance].pinnedCertificates];
    }else{
        securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
    }
        
    manager.securityPolicy = securityPolicy;

    if ([self requestMethod] == UURequestMethodGet) {
        [manager GET:URLString parameters:self.httpBody progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
            [self handleSuccess:operation response:responseObject];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self handleFail:operation error:error];
        }];
    }else if ([self requestMethod] == UURequestMethodPost) {
        if (!self.httpBody) {
            self.httpBody = @{};
        }
        [manager POST:URLString parameters:self.httpBody progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
            [self handleSuccess:operation response:responseObject];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self handleFail:operation error:error];
        }];
    }
}

- (void)handleSuccess:(NSURLSessionTask*) operation response:(id)responseObject {
//解析与服务器响应的数据不符合，暂时注释掉。
//    self.responseStatus = [[responseObject objectForKey:@"status"] intValue];
//    if(self.responseStatus == 200 && [self.parameters objectForKey:@"device_token"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"deviceTokenUploaded"];
//    }
//    self.errorMessage = [responseObject objectForKey:@"error_msg"];
    
    //增加token失效处理。
    id codeObj = responseObject[@"status"][@"code"];
    if (codeObj) {
        NSInteger code = [codeObj integerValue];
        UUErrorHandler *handler = [UUErrorHandler handlerWithDomain:nil code:code userInfo:nil];
        
        BOOL ret = [handler handleSuccess:^(id response) {
            //重新开始本次请求。
            [self start];
        } failure:^(NSError *error) {
            NSLog(@"%s, %@", __FUNCTION__, error);
            
            [self handleFail:nil error:error];
        }];
        
        if (ret){
            //将此响应结果交给error handler去处理。
            return;
        }
    }
    
    self.result = responseObject;//[responseObject objectForKey:@"data"];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:self.didFinishSelector]) {
            SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( [self.delegate performSelector:self.didFinishSelector withObject:self] );
        }
        return;
    }
}


- (void)handleFail:(NSURLSessionTask*)operation error:(NSError*)error {
    
    self.error = error;
    //TODO: 设置状态码
//    self.responseStatus = (int)operation.state
    if (self.delegate && [self.delegate respondsToSelector:self.didFailSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFailSelector withObject:self]);
    }

}

- (void)test {
    if ([self kindOfTest] == UURequestTestTypeSucceeded) {
        [self performSelector:@selector(testSucceeded) withObject:nil afterDelay:[self timeToDelay]];
    }else if([self kindOfTest] == UURequestTestTypeFailed) {
        [self performSelector:@selector(testFailed) withObject:nil afterDelay:[self timeToDelay]];
    }
     
}

- (void)testSucceeded {
    self.result = [self successResultForTest];
    self.responseStatus = 200;
    if (self.delegate && [self.delegate respondsToSelector:self.didFinishSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFinishSelector withObject:self]);
    }
}

- (void)testFailed {
    self.error = [self errorResultForTest];
    self.responseStatus = 400;
    if (self.delegate && [self.delegate respondsToSelector:self.didFailSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFailSelector withObject:self]);
    }
}

- (int)resultStatus {
    return self.responseStatus;
}
- (NSString*)resultErrorMessage {
    if (self.errorMessage) {
        return self.errorMessage;
    }
    return @"发生未知错误";
}

- (BOOL)requestSucceeded {
    return self.responseStatus == 200;
}

- (void)printObject:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        for (id obj  in (NSArray*)object) {
            [self printObject:obj];
        }
        return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (id key in [(NSDictionary *)object allKeys]) {
            [self printObject:key];
            [self printObject:[(NSDictionary *)object objectForKey:key]];
        }
        return;
    }
}

@end
