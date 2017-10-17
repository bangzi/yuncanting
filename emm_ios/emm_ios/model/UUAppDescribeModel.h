//
//  UUAppDescribeModel.h
//  emm_ios
//
//  Created by 冯海邦 on 16/5/3.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUModel.h"

@interface UUAppDescribeModel : UUModel

@property(nonatomic, strong)NSString *appName;
@property(nonatomic, strong)NSString *appPkgName;
@property(nonatomic, strong)NSString *appVersionName;
@property(nonatomic, strong)NSString *appSize;
@property(nonatomic, strong)NSString *appDescription;
@property(nonatomic, strong)NSString *appFilePath;
@property(nonatomic, strong)NSString *appIconPath;
@property(nonatomic, strong)NSString *appRebuildFile;
@property(nonatomic, strong)NSString *appUserConfig;
@property(nonatomic, assign)NSString *appSort;
@property(nonatomic, assign)NSString *catId;
@property(nonatomic, assign)NSString *cmdUuid;
@property(nonatomic, assign)NSString *isInstall;

@end
