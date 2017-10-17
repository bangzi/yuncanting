//
//  UULoginManager.m
//  emm_ios
//
//  Created by uusafe on 16/4/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UULoginManager.h"
#import "MDMUtils.h"
#import "UULocalPersistenceUtil.h"
#import "UUDatabaseManager.h"
#import "UUPasswordTool.h"
#import "BaseHeader.h"
#import "UUProjectInfo.h"
static NSDictionary *errorTipDict;
@implementation UULoginManager

+ (instancetype)shareManager {
    static UULoginManager *shareInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"checkerrorcode" ofType:@"plist"];
        if (path) {
            errorTipDict = [NSDictionary dictionaryWithContentsOfFile:path];
        }
    }
    return self;
}

- (void)setLoginStatus:(UUAppLoginStatus)loginStatus {
    if (_loginStatus == loginStatus) {
        return;
    }
    _loginStatus = loginStatus;
}

- (UUAppLoginStatus)loginStatus {
    return _loginStatus;
}

- (NSString *)errorTip:(id)aKey {
    return [errorTipDict objectForKey:[NSString stringWithFormat:@"%@",aKey]];
}
@end
