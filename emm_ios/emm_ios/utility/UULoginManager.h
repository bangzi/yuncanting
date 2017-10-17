//
//  UULoginManager.h
//  emm_ios
//
//  Created by uusafe on 16/4/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UUAppLoginStatus) {
    //第一步，初始化状态
    UUAppLoginStatusInit,
    //第二步，获取服务端生成的uuid
    UUAppLoginStatusEnroll,
    //第三步，下载profile文件
    UUAppLoginStatusDownloadProfile,
    //第四步，获取客户端udid
    UUAppLoginStatusGetUDID,
    //第五步，正式登陆
    UUAppLoginStatusLogin,
    
    UUAppLoginStatusRegisterSuccess
};

typedef NS_ENUM(NSInteger,UUCheckStatusError) {
    UUCheckStatusCompanyCodeError,
    UUCheckStatusUsernameError,
    UUCheckStatusPasswordError,
    UUCheckStatusNetworkError,
    UUCheckStatusUsernameIsNil,
    UUCheckStatusProfileIsExists,
    UUCheckStatusTip = -1
};

@interface UULoginManager : NSObject {
    UUAppLoginStatus _loginStatus;
}

@property (nonatomic, assign)UUAppLoginStatus loginStatus;

+ (instancetype)shareManager;

- (NSString *)errorTip:(id)aKey;

@end
