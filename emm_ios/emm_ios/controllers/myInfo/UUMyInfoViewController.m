//
//  UUMyInfoViewController.m
//  emm_ios
//
//  Created by 冯海邦 on 17/8/28.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUMyInfoViewController.h"
#import "UUMyInfoTableViewCell.h"
#import "CYFoodClassificationViewController.h"

@interface UUMyInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *funListArray;

@end

@implementation UUMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的";
    [self.tableView registerNib:[UINib nibWithNibName:@"UUMyInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"myInfo"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSArray *)funListArray {
    if (!_funListArray) {
        _funListArray = @[
                          @"连接打印机",
                          @"营业时间",
                          @"菜品管理"
                          ];
    }
    return _funListArray;
}

#pragma mark --- tableView的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UUMyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myInfo"];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.MyinfoCellLabel.text = self.funListArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYFoodClassificationViewController *tempFoodClass = [[CYFoodClassificationViewController alloc]init];
    [tempFoodClass setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:tempFoodClass animated:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
