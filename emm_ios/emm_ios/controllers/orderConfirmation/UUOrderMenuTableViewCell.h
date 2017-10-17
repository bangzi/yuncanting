//
//  UUOrderMenuTableViewCell.h
//  emm_ios
//
//  Created by 邦子 on 17/9/2.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUOrderMenuTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *foodName;
@property (strong, nonatomic) IBOutlet UILabel *foodPrice;
@property (strong, nonatomic) IBOutlet UILabel *foodNumber;
@property (strong, nonatomic) IBOutlet UILabel *remarks;

- (void)setFoodInfo:(NSDictionary *)foodInfo;

@end
