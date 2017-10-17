//
//  UUDatabaseManager.h
//  emm_ios
//
//  Created by uusafe on 16/4/14.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUNotification.h"
#import "UUNotificationModel.h"

@interface UUDatabaseManager : NSObject

@property (nonatomic,strong)NSManagedObjectContext *managerObjectContext;

+ (UUDatabaseManager *)shareInstance;

- (UUNotification *)insertIntoDataSource:(UUNotificationModel *)model;

- (NSArray *)query;

- (void)deleteAllData;

- (void)deleteWithPredicate:(NSString *)aString;

- (void)updateWithPredicate:(NSString *)aString withReaded:(NSNumber *)readed;

- (void)deleteNotification:(UUNotification *)notification;

- (void)updateWithNotification:(UUNotification *)notification;

- (NSArray *)objectArrayFromTableName:(NSString *)TableName;
- (void)deleteAllDataWithTableName:(NSString *)TableName;
- (void)deleteAttributeValue:(NSString *)attributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName;
- (NSMutableArray *)readAttributeValue:(NSString *)attributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName;
- (void)updataNewAttributeValue:(NSString *)newAttributeValue oldAttributeValue:(NSString *)oldAttributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName;
- (void)updataNewAttributeValue:(NSString *)newAttributeValue withAttribute:(NSString *)attribute readAttributeValue:(NSString *)readAttributeValue readAttribute:(NSString *)readAttribute inTableName:(NSString *)tableName;

@end
