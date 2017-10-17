//
//  PlayAudio.h
//  emm_ios
//
//  Created by uusafe on 16/4/18.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUPlayAudio : NSObject
+ (UUPlayAudio *)shareManger;
- (void)play:(NSString *)path;
- (void)dispose;

@end
