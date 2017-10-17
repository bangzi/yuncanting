//
//  UUAppDescribeModel.m
//  emm_ios
//
//  Created by 冯海邦 on 16/5/3.
//  Copyright © 2016年 uusafe. All rights reserved.
//

#import "UUAppDescribeModel.h"

@implementation UUAppDescribeModel

+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"app_name":@"appName",
                                 @"app_pkg_name":@"appPkgName",
                                 @"app_version_name":@"appVersionName",
                                 @"app_size":@"appSize",
                                 @"app_description":@"appDescription",
                                 @"app_file_path":@"appFilePath",
                                 @"app_icon_path":@"appIconPath",
                                 @"app_rebuild_file":@"appRebuildFile",
                                 @"app_user_config":@"appUserConfig",
                                 @"app_sort":@"appSort",
                                 @"cat_id":@"catId",
                                 @"cmdUuid":@"cmdUuid",
                                 @"isInstall":@"isInstall"
                                 }];
}


@end
