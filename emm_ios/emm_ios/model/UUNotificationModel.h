//
//  UUNotificationModel.h
//  emm_ios
//
//  Created by uusafe on 16/4/13.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"
typedef NS_ENUM(NSInteger,MessageType){
    text = 0,
    ring,
    waringing
};
@interface UUNotificationModel : UUModel
@property (nonatomic,assign)NSNumber<Optional> *messageType;
@property (nonatomic,strong)NSString<Optional> *messageAlert;
@property (nonatomic,strong)NSString<Optional> *messageSoundName;
@property (nonatomic,strong)NSNumber<Optional> *messageReaded;
@property (nonatomic,strong)NSString<Optional> *messageTitle;
@property (nonatomic,strong)NSString<Optional> *messageBody;
@property (nonatomic,strong)NSDate<Optional>   *messageDate;
@property (nonatomic,strong)NSString<Optional> *messageMSG;
@end
