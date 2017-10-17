//
//  UUOrderMenuTableViewCell.m
//  emm_ios
//
//  Created by 邦子 on 17/9/2.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUOrderMenuTableViewCell.h"

@implementation UUOrderMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFoodInfo:(NSDictionary *)foodInfo {
    self.foodName.text = foodInfo[@"foodName"];
    self.foodNumber.text = foodInfo[@"foodNumber"];
    self.foodPrice.text = foodInfo[@"foodPrice"];
    self.remarks.text = foodInfo[@"remarks"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
