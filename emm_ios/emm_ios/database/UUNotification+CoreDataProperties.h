//
//  UUNotification+CoreDataProperties.h
//  emm_ios
//
//  Created by uusafe on 16/4/14.
//  Copyright © 2016年 uusafe. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UUNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface UUNotification (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *messageType;
@property (nullable, nonatomic, retain) NSString *messageTitle;
@property (nullable, nonatomic, retain) NSString *messageBody;
@property (nullable, nonatomic, retain) NSDate   *messageDate;
@property (nullable, nonatomic, retain) NSString *messageMSG;
@property (nullable, nonatomic, retain) NSString *messageSoundName;
@property (nonatomic, nullable, retain) NSNumber *messageReaded;
@end

NS_ASSUME_NONNULL_END
