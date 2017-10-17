//
//  UUOrderConfirmationViewController.m
//  emm_ios
//
//  Created by 冯海邦 on 17/8/28.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUOrderConfirmationViewController.h"
#import "UUOrderMenuTableViewCell.h"

@interface UUOrderConfirmationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cellsIdentifier;
@property (strong, nonatomic) NSDictionary *classes;
@property (strong, nonatomic) NSArray *orderInfoArray;

@end

@implementation UUOrderConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"未处理";
    [self.tableView registerNib:[UINib nibWithNibName:@"UUOrderMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderMenu"];
    [self loadData];
}

- (void)loadData {
    self.orderInfoArray = @[
                            @{
                                @"foodName" : @"宫爆鸡丁",
                                @"foodNumber" : @"6",
                                @"foodPrice" : @"¥30",
                                @"remarks" : @"特辣"
                                },
                            @{
                                @"foodName" : @"西红柿炒鸡蛋",
                                @"foodNumber" : @"2",
                                @"foodPrice" : @"¥20",
                                @"remarks" : @"微辣"
                                },
                            @{
                                @"foodName" : @"尖椒肉丝",
                                @"foodNumber" : @"3",
                                @"foodPrice" : @"¥35",
                                @"remarks" : @"不辣"
                                },
                            ];
}

//确认接单
- (IBAction)sureButton:(id)sender {
    NSLog(@"确认接单");
}

//拒绝接单
- (IBAction)cancelButton:(id)sender {
    NSLog(@"拒绝接单");
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUOrderMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderMenu"];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setFoodInfo: self.orderInfoArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
