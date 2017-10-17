//
//  CYUntreatedViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/10/7.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "CYUntreatedViewController.h"
#import "CYUntreatedTableViewCell.h"
#import "UUOrderConfirmationViewController.h"

@interface CYUntreatedViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYUntreatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"未处理";
    [self.tableView registerNib:[UINib nibWithNibName:@"CYUntreatedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYUntreatedTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYUntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYUntreatedTableViewCell"];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    [cell setFoodInfo: self.orderInfoArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UUOrderConfirmationViewController *orderVC = [[UUOrderConfirmationViewController alloc] init];
    [orderVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:orderVC animated:YES];
}

@end
