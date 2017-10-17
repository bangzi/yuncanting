//
//  UIUtils.m
//  emm_ios
//
//  Created by maqj on 4/29/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UIUtils.h"
#import "AppDelegate.h"

@implementation UIUtils
+ (void)dialogWithTitle:(NSString*)title message:(NSString*)msg{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:alert animated:YES completion:nil];
    });
}
@end
