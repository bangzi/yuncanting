//
//  UUNotiPushModel.h
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UUModel.h"
#import <UIKit/UIKit.h>

extern NSString *const MDMStateChangedNotification;

@interface UUNotiPushModel : UUModel
@property (nonatomic, assign) NSNumber<Optional> *type;
@property (nonatomic, assign) NSNumber<Optional> *taskId;
@property (nonatomic, assign) int event;
@property (nonatomic, copy) NSString<Optional> *tips;
//@property (nonatomic, assign) int eraseType;
@end
