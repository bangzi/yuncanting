//
//  CYFoodClassificationViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/9/22.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "CYFoodClassificationViewController.h"
#import "CYFoodClassificationTableViewCell.h"
#import "foodListViewController.h"

@interface CYFoodClassificationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *foodClassification;



@end

@implementation CYFoodClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜品分类";
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CYFoodClassificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYFoodClassificationTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)foodClassification{
    if ( !_foodClassification) {
        _foodClassification =[@[
                               @"今日特色",
                               @"精品肉类",
                               @"时令蔬菜",
                               @"鲜榨饮品",
                               @"主食"] mutableCopy];
    }
    return _foodClassification;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYFoodClassificationTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"CYFoodClassificationTableViewCell"];
    cell.foodClassLable.text = self.foodClassification[indexPath.row];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foodClassification.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    foodListViewController *tempFoodList = [[foodListViewController alloc]init];
    
    [tempFoodList setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:tempFoodList animated:NO];

}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
