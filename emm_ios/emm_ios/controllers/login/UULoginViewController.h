//
//  UULoginViewController.h
//  emm_ios
//
//  Created by uusafe on 16/3/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UULoginDelegate<NSObject>
- (void)pushToMainViewController;

@end


typedef void (^DisplayTabbarBlock)(void);

@interface UULoginViewController : UIViewController
@property (nonatomic,copy)DisplayTabbarBlock displayTabbar;
@property (nonatomic,assign)id<UULoginDelegate> delegate;

- (IBAction)login:(id)sender;
@end
