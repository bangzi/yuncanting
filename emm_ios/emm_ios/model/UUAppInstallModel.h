//
//  UUAppInstallModel.h
//  emm_ios
//
//  Created by 冯海邦 on 16/5/5.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"

@interface UUAppInstallModel : UUModel

@property(nonatomic, strong)NSString *identifier;
@property(nonatomic, strong)NSString *uuid;
@property(nonatomic, strong)NSString *commandUUID;
@property(nonatomic, strong)NSString *event;

@end
