//
//  UURequestCMDReport.h
//  emm_ios
//
//  Created by maqj on 4/27/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UURequest.h"
#import "MDMNotifPushUtils.h"

@interface UURequestCMDReport : UURequest

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *companyCode;
@property (nonatomic, assign) NotifPushState event;
@property (nonatomic, strong) NSDictionary *data;
@end
