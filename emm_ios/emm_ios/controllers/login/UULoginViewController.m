//
//  UULoginViewController.m
//  emm_ios
//
//  Created by uusafe on 16/3/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UULoginViewController.h"
#import "DeviceInfo.h"
#import "NSString+encrypto.h"
#import "BaseHeader.h"
#import "UUID.h"
#import "UUModelLogin.h"
#import "JsonModel.h"
#import "UURequest.h"
#import "AFNetworking.h"
#import "NSString+Predicate.h"
#import "MBProgressHUD.h"
#import "UULocalPersistenceUtil.h"
#import "UUNotiPushModel.h"
#import "UUActivity.h"
#import "UIAlertView+Associate.h"
#import "UUModelActivity.h"
#import "UUPasswordTool.h"
#import "UULocalPersistenceUtil.h"
#import "MDMUtils.h"
#import "UURequest.h"
#import "UULoginManager.h"
#import "UUErrorHandler.h"
#import "UURegisterRequest.h"
#import "UULoginRequest.h"
#import "UUProjectInfo.h"
#import "UULoginManager.h"
#import "UUEnroll.h"
#import "UUEnrollModel.h"
#import "UUGetUDID.h"
#import "UUUDIDModel.h"
@interface UULoginViewController ()<NSURLSessionDelegate,ActivityDelegate,EnrollDelegate,GetUDIDDelegate>

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIView *loginBackgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundConstraint;

@property (weak, nonatomic) IBOutlet UITextField *companyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (nonatomic,assign) CGSize        keyboardSize;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *companycodebackView;
@property (weak, nonatomic) IBOutlet UIView *userNameBackView;
@property (weak, nonatomic) IBOutlet UIView *passwdBackView;
@property (weak, nonatomic) IBOutlet UIView *companyLineView;
@property (weak, nonatomic) IBOutlet UIView *userNameLineView;
@property (weak, nonatomic) IBOutlet UIView *passwdLineView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *companyCode;

@end

@implementation UULoginViewController{
    UUActivity *_activity;
    UUEnroll *_enroll;
    UUGetUDID *_getUDID;
    NSInteger _count;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [UULoginManager shareManager].loginStatus = UUAppLoginStatusInit;
        _count = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStatusChanged:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.navigationController.navigationBarHidden = YES;
    [self registerForKeyboardNotifications];
    
}

- (void)appStatusChanged:(NSNotification *)notification {
    NSError *error;
    UUAppLoginStatus status = [[UULoginManager shareManager] loginStatus];
    MDMProfileStatus profileStatus = [MDMUtils rootProfileStatus:&error];
    if (status == UUAppLoginStatusDownloadProfile && [UULocalPersistenceUtil sharedInstance].sessionUUID && profileStatus == MDMProfileStatusInstalled) {
        
        [UULoginManager shareManager].loginStatus = UUAppLoginStatusGetUDID;
        [self getDeviceUDID];
    }else {
        if (![_progressHUD isHidden]) {
            [_progressHUD hide:YES];
        }
    }
}

- (void)getDeviceUDID {
    _getUDID = [[UUGetUDID alloc]init];
    _getUDID.companyCode = self.companyCode;
    _getUDID.userName = self.userName;
    _getUDID.password = self.password;
    _getUDID.enrollId = [UULocalPersistenceUtil sharedInstance].securityId;
    _getUDID.delegate = self;
    [_getUDID getUDID];
}
#pragma enroll delegate methods
- (void)getUDIDSuccess:(UUUDIDModel *)model {
    switch (model.code) {
        case GetUDIDStatusSuccess: {
            if (model.udid == nil || [model.udid isEqualToString:@""]) {
                [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusProfileIsExists)]];
                return;
            }
            [UULocalPersistenceUtil sharedInstance].deviceUDID = model.udid;
            [UULoginManager shareManager].loginStatus = UUAppLoginStatusLogin;
            
            [self postLoginCompanyCode:self.companyCode name:self.userName passwd:self.password];
        }
            
            break;
        case GetUDIDStatusFail: {
            [self getUDIDFailed];
        }
            break;
        default:
            break;
    }
    
}

- (void)getUDIDFailed {
   [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusNetworkError)]];
    [_progressHUD hide:YES];
}

- (void)registerForKeyboardNotifications {
    
//    //增加监听，当键盘出现或改变时收出消息
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
- (void)keyboardWillShow:(NSNotification *)notifi {

    
    NSDictionary *info = [notifi userInfo];
 
    NSValue *value = [info objectForKey:UIKeyboardWillShowNotification];
    CGSize keyboardSize = [value CGRectValue].size;
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    CGFloat differ = (keyboardSize.height - (self.view.frame.size.height - _loginBackgroundView.frame.size.height));

    [UIView animateWithDuration:duration animations:^{
        _topConstraint.constant = differ;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
}
- (void)keyboardWillHide:(NSNotification *)notifi {
    NSDictionary *info = [notifi userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        _topConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notifi {

    CGRect currentFrame = self.view.frame;

    NSDictionary *info = [notifi userInfo];

    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
 //   CGRect beginKeyBoardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];

 //   CGFloat yOffset = endKeyboardRect.origin.y - beginKeyBoardRect.origin.y;

    CGFloat remainHeight = (self.view.frame.size.height - self.loginButton.frame.origin.y - self.loginButton.frame.size.height);

    CGFloat height = -(endKeyboardRect.size.height - remainHeight);

    currentFrame.origin.y = currentFrame.origin.y - height;
    //针对第三方输入法弹出事件短，动画生硬，优化
    if (duration < 0.1) {
        duration = 0.3;
    }
    
    if (self.view.frame.size.height - (endKeyboardRect.size.height) > self.loginButton.frame.origin.y + self.loginButton.frame.size.height) {
        height = 0.0;
    }

    [UIView animateWithDuration:duration animations:^{
        _topConstraint.constant = height;

        [self.view layoutIfNeeded];

        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardDidHidden:(NSNotification *)notifi {

    [UIView animateWithDuration:0.2 animations:^{
        _topConstraint.constant = 0;
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)login:(id)sender {
    
    _password = [_passwdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _companyCode = [_companyCodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _userName = [_userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (nil == self.companyCode || [self.companyCode isEqualToString:@""]) {
        [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusCompanyCodeError)]];
        return;
    }
    
    if ([self.userName isEqualToString:@""] || self.userName == nil) {
        [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusUsernameIsNil)]];
        return;
    }
    if (![self.userName isEmail]) {
        [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusUsernameError)]];
        return;
    }
    if ([_password isEqualToString:@""] || ![_password isPassword] ||_password == nil) {
        [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusPasswordError)]];
        return;
    }
  //  self.password = [_password stringByAppendingString:_userName];
    
    NSError *error;
    MDMProfileStatus status = [MDMUtils rootProfileStatus:&error];
    UUAppLoginStatus loginStatus = [[UULoginManager shareManager] loginStatus];
    
    switch (loginStatus) {
        case UUAppLoginStatusInit:
        case UUAppLoginStatusEnroll:
        case UUAppLoginStatusDownloadProfile:
        case UUAppLoginStatusLogin:
        case UUAppLoginStatusGetUDID: {
            //客户端检查是否登录
            if ([UULocalPersistenceUtil sharedInstance].sessionToken == nil && status == MDMProfileStatusInstalled) {
                
                [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusProfileIsExists)]];
                return;
            }
            
        }
            [UULoginManager shareManager].loginStatus = UUAppLoginStatusInit;
            break;
        case UUAppLoginStatusRegisterSuccess: {
            [self postLoginCompanyCode:self.companyCode name:self.userName passwd:self.password];
        }
            break;
        default:
            break;
    }
//    if ([UULocalPersistenceUtil sharedInstance].sessionToken != nil && status == MDMProfileStatusInstalled) {
//      
//        if ([[UULocalPersistenceUtil sharedInstance].loginUserName isEqualToString:_userName] && [[UULocalPersistenceUtil sharedInstance].loginPassword isEqualToString:_password]) {
//            [self.delegate pushToMainViewController];
//            return;
//        }
//        
//    }
    //其他情况 未登录未安装profile文件
    
    if ([UULoginManager shareManager].loginStatus == UUAppLoginStatusInit) {
        _enroll = [[UUEnroll alloc]init];
        _enroll.companyCode = self.companyCode;
        _enroll.userName = self.userName;
        _enroll.password = self.password;
        _enroll.enrollId = [UULocalPersistenceUtil sharedInstance].securityId;
        _enroll.delegate = self;

        [_enroll enrollForUUID];
    }
    [self.view endEditing:YES];
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

}
#pragma mark -- enroll delegate methods
- (void)enrollSuccess:(UUEnrollModel *)model {
    switch (model.code) {
        case EnrollStatusSuccess: {
            if (model.uuid == nil || [model.uuid isEqualToString:@""]) {
                [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusProfileIsExists)]];
                return;
            }
            [UULocalPersistenceUtil sharedInstance].sessionUUID = model.uuid;
            [UULoginManager shareManager].loginStatus = UUAppLoginStatusDownloadProfile;
            [self openURLRequest:[model.uuid copy]];
        }
            break;
        case EnrollStatusFail: {
            
            [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusUsernameError)]];
            [_progressHUD hide:YES];
        }
        default:
            break;
    }
    
}

- (void)enrollFailed {
    [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusNetworkError)]];
    [_progressHUD hide:YES];
}

- (void)alertViewInfoTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)postLoginCompanyCode:(NSString *)companyCode name:(NSString *)name passwd:(NSString *)passwd {
    
    
  //  NSString *url = @"http://192.168.1.120:3002/uusafe/api/device/login";
    
 //   NSString *url = [BASEURL stringByAppendingString:@"/api/device/login"];

    NSString *securityId = [UULocalPersistenceUtil sharedInstance].deviceUDID;
    

    NSString *excutableVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];

    NSDictionary *parameters = @{@"userName":name,@"password":passwd,@"securityId":securityId,@"companyCode":companyCode,@"clientVersion":excutableVersion};
    
#if DEBUG
    NSLog(@"%s, %@", __FUNCTION__, parameters);
#endif
    
    UULoginRequest *request = (UULoginRequest *)[UULoginRequest requestWithName:@"loginRequest"];
    request.delegate = self;
    request.httpBody = parameters;
    request.didFinishSelector = @selector(finished:);
    request.didFailSelector = @selector(failed:);
    [request start];
}

- (void)finished:(UURegisterRequest *)request {
    if (nil == request.result) {
        return;
    }
    
    NSError *error = nil;
    
    UUModelLogin *loginModel = [[UUModelLogin alloc] initWithDictionary:request.result error:&error];
    [_progressHUD hide:YES];
    NSLog(@"%s,%@",__func__,[UULocalPersistenceUtil sharedInstance].deviceUDID);
    
    switch (loginModel.code) {
        //状态12：设备未受控
        case LoginStatusSuccessButNoRegister: {
            [UULocalPersistenceUtil sharedInstance].loginUserName = self.userName;
            [UULocalPersistenceUtil sharedInstance].loginPassword = self.password;
            [UULocalPersistenceUtil sharedInstance].loginCompanyCode = self.companyCode;
            //注册
            [self registerDevice];

        }
            break;
        //状态14：设备受控
        case LoginStatusDeviceActivitied: {
            [UULocalPersistenceUtil sharedInstance].clientUserId = loginModel.userId;
            [UULocalPersistenceUtil sharedInstance].loginCompanyCode = self.companyCode;
            [UULocalPersistenceUtil sharedInstance].loginUserName = self.userName;
            [UULocalPersistenceUtil sharedInstance].loginPassword = self.password;
            [UULocalPersistenceUtil sharedInstance].sessionToken = loginModel.token;
            [UULocalPersistenceUtil sharedInstance].clientPassword = loginModel.clientPassword;
            [UULocalPersistenceUtil sharedInstance].clientUserName = loginModel.userName;
            [UULocalPersistenceUtil sharedInstance].sessionUUID = loginModel.uuid;
            [UULocalPersistenceUtil sharedInstance].encryptKey = loginModel.encryptKey;
            [UULocalPersistenceUtil sharedInstance].encryptType = loginModel.encryptType;
            [UULocalPersistenceUtil sharedInstance].dataTransmissionInterval = loginModel.dataTransmissionInterval;

          //  [self openURLRequest:[loginModel.uuid copy]];
            [self.delegate pushToMainViewController];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

        }
            break;
        case LoginStatusUserNameOrPasswdError:
        case LoginStatusDeviceRegistered:
        case LoginStatusDevicePendingWiped:
        case LoginStatusDeviceWiped:
        case LoginStatusDeviceLosted:
        case LoginStatusDeviceDeleted:
        case LoginStatusServiceError:
        case LoginStatusTokenInvalid:
        case LoginStatusForbidRegister:
        case LoginStatusForbidActivity:
        case LoginStatusRegisterUserBeyond:
        case LoginStatusUserDisable:
        default:
            [self alertViewInfoTitle:@"提示" message:loginModel.message];
            break;
    }
}
- (void)registerDevice {
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _activity = [[UUActivity alloc]init];
    _activity.delegate = self;
    
    [_activity activityDevice];
}

#pragma mark -- activity delegate methods
/**
 *  注册回调
 *
 *  @param code 回调状态参数
 */
- (void)activitySuccess:(UUModelActivity *)model {
    
    [_progressHUD hide:YES];
    switch (model.code) {
        
        //设备注册成功
        case RegisterStatusSuccess: {
            [UULoginManager shareManager].loginStatus = UUAppLoginStatusRegisterSuccess;
            [self login:nil];
        }
            break;
        //设备注册失败
        case RegisterStatusFailed:
        //设备已激活，不能重复注册
        case RegisterStatus_OS_Platform_Error:
        //设备参数错误,
        case RegisterStatus_OS_Model_Error:
        //请求失败
        case RegisterStatusRequesetFailed:
        case RegitterStatus_OS_Version_Error:
        case RegisterStatus_OS_Security_ID_Error:
        case RegisterStatus_Company_Code_Error:
        default:
            [self alertViewInfoTitle:@"提示" message:model.message];
            break;
    }
    
}

- (void)activityFailed {
    [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusNetworkError)]];
    [_progressHUD hide:YES];
}

- (void)openURLRequest:(NSString *)uuid {
    NSString *str = [NSString stringWithFormat:[UUProjectInfo sharedInstance].mobileConfigURL, uuid, self.companyCode];

    NSURL *url = [NSURL URLWithString:str];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        [UULoginManager shareManager].loginStatus = UUAppLoginStatusDownloadProfile;
    }
}

- (void)failed:(UURegisterRequest *)request {
    [self alertViewInfoTitle:[[UULoginManager shareManager] errorTip:@(UUCheckStatusTip)] message:[[UULoginManager shareManager] errorTip:@(UUCheckStatusNetworkError)]];
    [_progressHUD hide:YES];
    
}
//- (void)setPassword:(NSString *)password
//{
//    _password = [password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//}
//- (void)setCompanyCode:(NSString *)companyCode
//{
//    _companyCode = [companyCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//}
//- (void)setUserName:(NSString *)userName
//{
//   _userName = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES ];
}
@end
