//
//  UUMyOrderViewController.m
//  emm_ios
//
//  Created by 冯海邦 on 17/8/28.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUMyOrderViewController.h"
#import "UUOrderListTableViewCell.h"
#import "UUOrderDetailsViewController.h"

@interface UUMyOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UUMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单信息";
    [self.tableView registerNib:[UINib nibWithNibName:@"UUOrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderList"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setHidesBottomBarWhenPushed:NO];
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderList"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UUOrderDetailsViewController *tempVC = [[UUOrderDetailsViewController alloc] init];
    [tempVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:tempVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
