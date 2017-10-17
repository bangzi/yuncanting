//
//  MDMNotifPushHandler.h
//  emm_ios
//
//  Created by maqj on 4/15/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUNotiPushModel.h"
#import "UUNotiPushAppRuleModel.h"

@interface MDMNotifPushHandler : NSObject

@property (nonatomic, copy) void (^completedBlock)(void);

/*
  //擦除企业内部数据，调用haibing接口
 */
- (void)handleEraseEMM:(UUNotiPushModel *)model;

/*
  删除设备，目前操作跟擦除设备一样。
 */
- (void)handleDeviceDelete:(UUNotiPushModel*)model;

/*
  设备信息更新，包括：设备名称(xuming's ipad)，型号(iPad 2, 32G, MC770CH)，OS版本，是否越狱，存储容量，电源状态
 */
- (void)handleDeviceUpdate:(UUNotiPushModel *)model;

/*
  //当前位置信息上报
 */
- (void)handleLocationUpdate:(UUNotiPushModel *)model;

/*
  黑白名单，必备应用的处理
 */
- (void)handleAppRule:(UUNotiPushAppRuleModel *)model;

/*
 设备丢失的处理，只在进入emm的时候，保持登陆状态，出现一把大锁，不让用就可以，但是还是需要接受和处理推送；不需要清除数据，不需要卸载软件
 handleDeviceLost, handleDeviceFound均不上报结果。
 */
- (void)handleDeviceLost:(UUNotiPushModel *)model;
- (void)handleDeviceFound:(UUNotiPushModel*)model;

/*
 检测本地root profile 是否安装
 */
- (void)handleCheckProfile:(UUNotiPushModel*)model;

@end
