//
//  UUModelActivity.h
//  emm_ios
//
//  Created by uusafe on 16/4/7.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
typedef NS_ENUM(NSInteger,RegisterStatus) {
    RegisterStatusFailed = 0,
    RegisterStatusSuccess,
    RegisterStatus_OS_Platform_Error,
    RegisterStatus_OS_Model_Error,
    RegitterStatus_OS_Version_Error,
    RegisterStatus_OS_Root_Error,
    RegisterStatus_OS_Belong_Type_Error,
    RegisterStatus_OS_DeviceName_Error,
    RegisterStatus_OS_Security_ID_Error,
    RegisterStatus_OS_WIFI_Mac_Error,
    RegisterStatus_Company_Code_Error = -3,
    RegisterStatusRequesetFailed = -1,
};
@interface UUModelActivity : UUModel
@property (nonatomic, assign) RegisterStatus  code;
@property (nonatomic, strong) NSString<Optional>  *message;
@property (nonatomic, strong) NSString<Optional>  *uuid;
@end
