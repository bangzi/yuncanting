//
//  UUDatabaseManager.m
//  emm_ios
//
//  Created by uusafe on 16/4/14.
//  Copyright © 2016年 uusafe. All rights reserved.
//
#define TBALENAME @"UUNotification"
#import "UUDatabaseManager.h"
#import "UUNotificationModel.h"
#import <CoreData/CoreData.h>

@interface UUDatabaseManager ()

@end

@implementation UUDatabaseManager
+ (UUDatabaseManager *)shareInstance {
    static UUDatabaseManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [[self alloc]init];
        
    });
    return manager;
}
//- (instancetype)initWithMnagerObjectContext:(NSManagedObjectContext *)manageObjectContext
//{
//    if (self = [super init]) {
//        self.manageObjectContext = manageObjectContext;
//    }
//    return self;
//}
- (UUNotification *)insertIntoDataSource:(UUNotificationModel *)model {

    UUNotification *notification = (UUNotification *)[NSEntityDescription insertNewObjectForEntityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
    [notification setMessageType:[NSNumber numberWithInteger:[model.messageType integerValue]]];
    [notification setMessageTitle:model.messageTitle];
    [notification setMessageBody:model.messageBody];
    [notification setMessageDate:model.messageDate];
    [notification setMessageMSG:model.messageMSG];
    [notification setMessageSoundName:model.messageSoundName];
    [notification setMessageReaded:model.messageReaded];
    
    NSError *error;
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"保存成功");
        
    }
    return notification;
    
}
//查询全部
- (NSArray *)query
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *notification = [NSEntityDescription entityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
    [request setEntity:notification];
    NSError *error = nil;
    
    NSMutableArray *mutableFetchResult = [[self.managerObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if (nil == mutableFetchResult) {
        NSLog(@"Error --%@",error);
    }
    
    for (UUNotification *notification in mutableFetchResult) {
        NSLog(@"messageType:%@---messageTitle:%@---messageBody:%@---messageDate:%@,--messageReaded:%@",notification.messageType,notification.messageTitle,notification.messageBody,notification.messageDate,notification.messageReaded);
        //        UUNotificationModel *model = [[UUNotificationModel alloc]init];
        //        model.messageType = notification.messageType.intValue;
        //        model.messageTitle = notification.messageTitle;
        //        model.messageBody = notification.messageBody;
        //        model.messageDate = notification.messageDate;
        //        model.messageReaded = notification.messageReaded;
        //        model.messageAlert = notification.messageAlert;
        [array addObject:notification];
        
        
    }
    return array;
}

- (void)updateWithNotification:(UUNotification *)notification
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
    [request setEntity:description];
    
    [notification setMessageReaded:[NSNumber numberWithInt:1]];
    
     NSError *error = nil;
    
    [self.managerObjectContext save:&error];
    
    NSLog(@"update--%@",error);
    
}

- (void)deleteAllData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UUNotification"];
    NSError *error;
    NSArray *array = [self.managerObjectContext executeFetchRequest:request error:&error];
    
    for (UUNotification *notifi in array) {
       [self.managerObjectContext deleteObject:notifi];
    }
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        NSLog(@"删除成功");
    }
}

- (void)deleteNotification:(UUNotification *)notification
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
   [request setEntity:description];
     NSError *error = nil;
    [self.managerObjectContext deleteObject:notification];
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        NSLog(@"删除成功");
    }
}

/**
 *  使用messageTitle 作为唯一性查询
 *
 *  @param aString messageTitle
 */
- (void)deleteWithPredicate:(NSString *)aString
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *notification = [NSEntityDescription entityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
    [request setEntity:notification];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageTitle == %@",aString];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    //查询条件
    NSMutableArray *mutableFetchResult = [[self.managerObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"the cout of entry:%ld",[mutableFetchResult count]);
    for (UUNotification *notification in mutableFetchResult) {
        [self.managerObjectContext deleteObject:notification];
    }
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
        NSLog(@"删除成功");
    }
}

- (void)updateWithPredicate:(NSString *)aString withReaded:(NSNumber *)readed {

    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *notification = [NSEntityDescription entityForName:@"UUNotification" inManagedObjectContext:self.managerObjectContext];
    [request setEntity:notification];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageTitle==%@",aString];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    //查询条件
    NSMutableArray *mutableFetchResult = [[self.managerObjectContext executeFetchRequest:request error:&error]mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error:%@",error);
    }
    NSLog(@"the cout of entry:%ld",[mutableFetchResult count]);
    
    for (UUNotification *notification in mutableFetchResult) {
        [notification setMessageReaded:readed];
    }
    
    [self.managerObjectContext save:&error];
    
}

#pragma mark -

- (NSArray *)objectArrayFromTableName:(NSString *)tableName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managerObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:tableName];
    [request setEntity:entity];
    NSArray *array = [self.managerObjectContext executeFetchRequest:request error:nil];
    return array;
}

- (void)deleteAllDataWithTableName:(NSString *)TableName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:self.managerObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error;
    NSArray *array = [self.managerObjectContext executeFetchRequest:request error:&error];
    for (id model in array) {
        [self.managerObjectContext deleteObject:model];
    }
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"删除成功");
    }
}

- (void)deleteAttributeValue:(NSString *)attributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName {
    NSArray *array = [self readAttributeValue:attributeValue withAttribute:attribute inTableName:tableName];
    for (id model in array) {
        [self.managerObjectContext deleteObject:model];
    }
    NSError *error = nil;
    if ([self.managerObjectContext save:&error]) {
        NSLog(@"删除成功");
    }
}

- (NSMutableArray *)readAttributeValue:(NSString *)attributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managerObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@==%@", attribute, attributeValue];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSMutableArray *array = [[self.managerObjectContext executeFetchRequest:request error:&error] mutableCopy];
    NSLog(@"%@", array);
    return array;
}

- (void)updataNewAttributeValue:(NSString *)newAttributeValue oldAttributeValue:(NSString *)oldAttributeValue withAttribute:(NSString *)attribute inTableName:(NSString *)tableName {
    NSArray *array = [self readAttributeValue:oldAttributeValue withAttribute:attribute inTableName:tableName];
    for (id model in array) {
        [model setValue:newAttributeValue forKey:attribute];
    }
    NSError *error = nil;
    if ([self.managerObjectContext save:&error]) {
       // NSLog(@"修改成功");
    }
}

- (void)updataNewAttributeValue:(NSString *)newAttributeValue withAttribute:(NSString *)attribute readAttributeValue:(NSString *)readAttributeValue readAttribute:(NSString *)readAttribute inTableName:(NSString *)tableName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self.managerObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appPkgName==%@", readAttributeValue];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSMutableArray *array = [[self.managerObjectContext executeFetchRequest:request error:&error] mutableCopy];
    for (id model in array) {
        [model setValue:newAttributeValue forKey:attribute];
    }
    if ([self.managerObjectContext save:&error]) {
        //NSLog(@"修改成功");
    }
}

@end
