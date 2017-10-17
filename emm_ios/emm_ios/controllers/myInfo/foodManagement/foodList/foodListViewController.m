//
//  foodListViewController.m
//  emm_ios
//
//  Created by 邦子 on 17/9/24.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "foodListViewController.h"
#import "foodListTableViewCell.h"
#import "CYAddAlterFoodViewController.h"

#define SCREENWIDTH [ UIScreen mainScreen ].bounds.size.width
#define SCREENHEIGHT [ UIScreen mainScreen ].bounds.size.height

@interface foodListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *foodListTableView;
@property (strong,nonatomic)NSMutableArray *foodListArr;

@end

@implementation foodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"菜品管理";
    // Do any additional setup after loading the view from its nib.
    [self.foodListTableView registerNib:[UINib nibWithNibName:@"foodListTableViewCell" bundle:nil] forCellReuseIdentifier:@"foodListTableViewCell"];
    self.foodListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    UINavigationBar *navBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
//    backButtonItem.title = @"我的";
//    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIButton *leftBarButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [leftBarButton setImage:[UIImage imageNamed:@"nav_return_"] forState:UIControlStateNormal ];
    [leftBarButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarButton];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add_"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
}

-(void)rightBarItemClick{
    
}

-(void)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)foodListArr{
    if (_foodListArr == nil) {
        _foodListArr =[@[@"小炒肉",@"刀削面",@"烤冷面",@"烧茄子"]mutableCopy];
    }
    return _foodListArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foodListArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    foodListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"foodListTableViewCell"];
    cell.foodNameLabel.text = self.foodListArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYAddAlterFoodViewController *tempAddALterFoodView =[[CYAddAlterFoodViewController alloc]init];
     [tempAddALterFoodView setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:tempAddALterFoodView animated:NO];
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
