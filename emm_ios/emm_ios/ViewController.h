//
//  ViewController.h
//  emm_ios
//
//  Created by uusafe on 16/3/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUViewController.h"
#import "UULoginViewController.h"

@interface ViewController : UUViewController <UULoginDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate>

- (void)setupTabbarController;
- (void)pushAppStoreView;

@end

