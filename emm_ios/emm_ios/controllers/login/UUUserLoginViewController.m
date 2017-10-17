//
//  UUUserLoginViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/9/9.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUUserLoginViewController.h"
#import "UUTextField.h"
#import "MBProgressHUD.h"
#import "UURequestLogin.h"

@interface UUUserLoginViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UUTextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UUTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *getVerificationCodeButton;
@property (strong, nonatomic) IBOutlet UILabel *timeCountdownLable;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIView *loginBackgroundView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;



@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;

@end

@implementation UUUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self registerForKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.userNameTextField.text = @"13521327593";
    self.passwordTextField.text = @"11111111";
}

//点击登录
- (IBAction)loginButton:(id)sender {
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.userName = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.userName.length == 0) {
        [self alertViewInfoTitle:@"提示" message:@"请输入您的帐号" cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.progressHUD setHidden:YES];
        return;
    }
    if (self.password.length == 0) {
        [self alertViewInfoTitle:@"提示" message:@"请输入您的密码" cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.progressHUD setHidden:YES];
        return;
    }
    
    
    UURequestLogin *request = [[UURequestLogin alloc] init];
    request.delegate = self;
    request.httpBody = @{
//                         @"name":@"12521327593",
//                         @"pwd":@"11111111",
                         @"code":@"123456"
                         };
    request.didFailSelector = @selector(requestDidFail:);
    request.didFinishSelector = @selector(requestDidFinish:);
    [request start];
}

- (void)requestDidFinish:(UURequest *)request {
    NSLog(@"%@", request.result);
    [self.progressHUD setHidden:YES];
}

- (void)requestDidFail:(UURequest *)request {
    NSLog(@"%@", request.error);
    [self.progressHUD setHidden:YES];
}

//点击忘记密码按钮
- (IBAction)forgetPasswordButton:(id)sender {
    
}

- (void)alertViewInfoTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alertView show];
}

//输入法弹出事件短，动画生硬，优化
- (void)registerForKeyboardNotifications {
    self.userNameTextField.tintColor = [UIColor blueColor];
    self.passwordTextField.tintColor = [UIColor blueColor];
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
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
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
    [UIView animateWithDuration:0.5 animations:^{
        _topConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
