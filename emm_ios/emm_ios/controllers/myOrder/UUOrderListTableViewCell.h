//
//  UUOrderListTableViewCell.h
//  emm_ios
//
//  Created by 邦子 on 17/9/2.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUOrderListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *foodNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderId;
@property (strong, nonatomic) IBOutlet UILabel *totalMoneyLabel;

- (void)setOrderListValue:(id)object;

@end
