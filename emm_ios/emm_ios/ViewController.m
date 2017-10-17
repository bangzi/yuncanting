//
//  ViewController.m
//  emm_ios
//
//  Created by uusafe on 16/3/25.
//  Copyright © 2016年 uusafe. All rights reserved.
//
#import "UUNavigationController.h"
#import "UIImage+ImageFromColor.h"
#import "ViewController.h"
#import "NSString+encrypto.h"
#import "NSString+DateFormat.h"
#import "UULocalPersistenceUtil.h"
#import "UUOrderConfirmationViewController.h"
#import "UUMyOrderViewController.h"
#import "UUMyInfoViewController.h"
#import "UUUserLoginViewController.h"
#import "CYUntreatedViewController.h"

#define FIRST_LAUNCHED @"firststart"
#define ANGLE(a) 2*M_PI/360 * a

#define COLOR(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]
#define COLOR_HEX(hex) [UIColor colorWithRed:(0xff0000&hex)/255.f green:(0xff00&hex)/255.f blue:(0xff&hex)/255.f alpha:1]

@interface ViewController ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UITabBarController *tabbarController;
@property (nonatomic, strong) UULoginViewController *loginViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewController];
    [self loadViewController];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/**
 * 推送到某个控制器
 */
- (void)pushAppStoreView {
    [self.tabbarController setSelectedIndex:1];
}

- (void)initViewController {
    if ([UULocalPersistenceUtil isFirstLaunched]) {
        //第一次启动
        [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusLogin];
    }else{
        //不是第一次启动，并且用户名和密码都已存在
        [[UULocalPersistenceUtil sharedInstance] setAppStatus:UUAppStatusNormal];
    }
}



/**
 *  修改进入主页或者登录界面
 */
- (void)loadViewController {
    [self clearAllViewController];
    [self setupTabbarController];
//    [self setupLoginViewController];
    return;
}

/**
 * 清除上一层的所有控制器
 */
- (void)clearAllViewController {
    if (self.tabbarController) {
        [self.tabbarController viewWillDisappear:NO];
        [self.tabbarController.view removeFromSuperview];
        [self.tabbarController viewDidDisappear:NO];
        [self.tabbarController removeFromParentViewController];
    }
    if (self.navigationController) {
        [self.navigationController viewWillDisappear:NO];
        [self.navigationController.view removeFromSuperview];
        [self.navigationController viewDidDisappear:NO];
        [self.navigationController removeFromParentViewController];
    }
}

- (void)setupLoginViewController {
//    UULoginViewController *loginViewController = [[UULoginViewController alloc] initWithNibName:@"UULoginViewController" bundle:nil];
//    loginViewController.delegate = self;
//    _navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
//    [self.view addSubview:_navigationController.view];
//    [self addChildViewController:_navigationController];
    UUUserLoginViewController *loginVC = [[UUUserLoginViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.view addSubview:_navigationController.view];
    [self addChildViewController:_navigationController];
}

/**
 * 设置tabbar
 */
- (void)setupTabbarController {
    [self loadTabbarController];
    [self.view addSubview:_tabbarController.view];
    [self addChildViewController:_tabbarController];
}

- (void)loadTabbarController {
    self.tabbarController = [[UITabBarController alloc] init];
    CYUntreatedViewController *order = [[CYUntreatedViewController alloc] initWithNibName:@"CYUntreatedViewController" bundle:nil];
    UUMyOrderViewController *myOrder = [[UUMyOrderViewController alloc] initWithNibName:@"UUMyOrderViewController" bundle:nil];
    UUMyInfoViewController *myInfo = [[UUMyInfoViewController alloc] initWithNibName:@"UUMyInfoViewController" bundle:nil];
    UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:order];
    UINavigationController *myOrderNav = [[UINavigationController alloc] initWithRootViewController:myOrder];
    UINavigationController *myInfoNav = [[UINavigationController alloc] initWithRootViewController:myInfo];

    self.tabbarController.viewControllers = @[orderNav, myOrderNav, myInfoNav];

    [self customizeTabBarForController:self.tabbarController];
}

- (void)customizeTabBarForController:(UITabBarController *)tabBarController {
    [[UITabBar appearance] setTranslucent:NO];
//    float width = self.view.frame.size.width / self.tabBarController.viewControllers.count;
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageWithColor:[UIColor colorWithRed:59.0/255 green:68.0/255 blue:90.0/255 alpha:1.0] size:CGSizeMake(width, 49)]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0]];

    NSArray *tabBarItemImages = @[@"main_icon01", @"main_icon02", @"main_icon03"];
    NSDictionary *tabTitles = @{@"main_icon01":@"未处理",
                                @"main_icon02":@"已处理",
                                @"main_icon03":@"我的",
                                };
    
    NSInteger index = 0;
    for (UITabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        item.title = tabTitles[tabBarItemImages[index]];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR(51, 51, 51), NSFontAttributeName: [UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR(254, 151, 15), NSFontAttributeName: [UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
        
        [item setSelectedImage:[selectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setImage:[unselectedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setTitle:[tabTitles objectForKey:[tabBarItemImages objectAtIndex:index]]];
        index++;
    }
}

- (void)activitySucess:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"activitySucess" object:nil];
}

#pragma mark -- login deletegate methods
- (void)pushToMainViewController {
    [[UULocalPersistenceUtil sharedInstance]setAppStatus:UUAppStatusNormal];
    [self loadViewController];
}

/**
 *  设置锚点后，重新定位
 *
 *  @param anchorPoint 锚点
 *  @param view        要设置的view
 */
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldPoint = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    
    CGPoint newOrigin = view.frame.origin;
    CGPoint transition;
    transition.x = newOrigin.x - oldPoint.x;
    transition.y = newOrigin.y - oldPoint.y;
    
    view.center = CGPointMake(view.center.x - transition.x, view.center.y - transition.y);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
