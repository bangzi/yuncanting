//
//  PlayAudio.m
//  emm_ios
//
//  Created by uusafe on 16/4/18.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUPlayAudio.h"
#import <AudioToolbox/AudioToolbox.h>
#define SYSTEMSOUNDID 1007
@implementation UUPlayAudio
{
   SystemSoundID soundID;
}

+ (UUPlayAudio *)shareManger
{
    static UUPlayAudio *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        manager = [[self alloc]init];
        
    });
    return manager;
}
- (void)play:(NSString *)path
{
    if ([path isEqualToString:@"default"]) {
        soundID = SYSTEMSOUNDID;
    }else{
        NSURL *url = [self getSoundURLString:path];
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(soundID);
}

- (void)dispose
{
    AudioServicesDisposeSystemSoundID(soundID);
}

- (NSURL *)getSoundURLString:(NSString *)aString
{
    NSArray *array = [aString componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:array[0] ofType:array[1]];
    
    NSURL *url = [NSURL fileURLWithPath:filePath isDirectory:NO];
    
    return url;
}
@end
