//
//  CYAddAlterFoodViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/9/24.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "CYAddAlterFoodViewController.h"
#import "UUButton.h"
#import "CYAddAlterFoodTableViewCell.h"

@interface CYAddAlterFoodViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *addAlterTableView;
@property (strong, nonatomic) IBOutlet UIButton *addFoodPictureButton;
@property (strong, nonatomic) IBOutlet UUButton *cancelButton;
@property (strong, nonatomic) IBOutlet UUButton *confirmButton;

@property (strong, nonatomic) NSArray *foodInfoArr;


@end

@implementation CYAddAlterFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.addAlterTableView registerNib:[UINib nibWithNibName:@"CYAddAlterFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"CYAddAlterFoodTableViewCell"];
    self.addAlterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSArray *)foodInfoArr{
    if (!_foodInfoArr) {
        _foodInfoArr = @[@"菜名 :",@"种类 :",@"口味 :",@"原价 :",@"优惠价 :"];
    }
    return _foodInfoArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foodInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYAddAlterFoodTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CYAddAlterFoodTableViewCell" ];
    cell.foodInfoLable.text = self.foodInfoArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
