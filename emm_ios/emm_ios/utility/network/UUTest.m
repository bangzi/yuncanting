//
//  UUTest.m
//  emm_ios
//
//  Created by yangzigang on 16/4/5.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUTest.h"
#import "UUModel.h"
#import "DeviceInfo.h"
#import "AppDelegate.h"
#import "DBTest+CoreDataProperties.h"

//https://github.com/icanzilb/JSONModel/#fork-destination-box
@interface UUJSONModelTest : UUModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) float age;
@property (nonatomic, strong) NSString<Ignore>* customProperty;

@end

@implementation UUJSONModelTest


+ (JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"sex":@"gender"}];
}

- (void)setNameWithNSString:(NSString*)string {
    self.name = [@"prefix-" stringByAppendingString:string];
    self.customProperty = @"ignored";
}

- (void)setAgeWithNSNumber:(NSNumber*)number {
    self.age = [number floatValue] * 3.0;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation UUTest

- (void)testNetwork {
    UURequest *request = [UURequest requestWithName:@"test"];
    request.delegate = self;
    request.didFailSelector = @selector(didFaile:);
    request.didFinishSelector = @selector(didFinish:);
    [request start];
}

- (void)didFaile:(UURequest*)request {
    
}

- (void)didFinish:(UURequest*)request {

}

- (void)testJSONModel {
    NSDictionary *dict = @{@"name":@"tom",
                           @"sex":@"男",
                           @"age":@16.0};
    NSError *err = nil;
    UUJSONModelTest *modelTest = [[UUJSONModelTest alloc] initWithDictionary:dict error:&err];
    NSLog(@"%@ %@ %f %@", modelTest.name, modelTest.gender, modelTest.age, modelTest.customProperty);
    
    
    err = nil;
    modelTest = [[UUJSONModelTest alloc] initWithDictionary:@{} error:&err];
    modelTest.age = 180;
    modelTest.gender = @"女";
//    modelTest.name = @"指掌易";
    NSDictionary *dict2 = [modelTest toDictionary];
    NSLog(@"%@", dict2);
}

- (void)testDeviceInfo {
    NSLog(@"%@", [DeviceInfo DeviceType]);
}

- (void)testDataBase {
//    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    NSManagedObjectContext *objectContext = appDelegate.managedObjectContext;
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DBTest" inManagedObjectContext:objectContext];
//    DBTest *dbTest = (DBTest*)[[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:objectContext];
//    dbTest.test = @"abc";
//    [objectContext save:nil];
}

@end
