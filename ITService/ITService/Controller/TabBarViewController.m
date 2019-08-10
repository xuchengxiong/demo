//
//  TabBarViewController.m
//  ITService
//
//  Created by 许成雄 on 2018/12/23.
//  Copyright © 2018 km_nogo. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "ServiceViewController.h"
#import "MeViewController.h"

@interface TabBarViewController ()

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) ServiceViewController *serviceViewController;
@property (strong, nonatomic) MeViewController *meViewController;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.homeViewController = [[HomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    UIImage *homeNormalImage = [[UIImage imageNamed:@"ic_tab_home_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelectedImage = [[UIImage imageNamed:@"ic_tab_home_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNavigationController.tabBarItem.image = homeNormalImage;
    homeNavigationController.tabBarItem.selectedImage = homeSelectedImage;
    homeNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    homeNavigationController.title = @"主页";
    
    
    self.serviceViewController = [[ServiceViewController alloc] init];
    UINavigationController *serviceNavigationController = [[UINavigationController alloc] initWithRootViewController:self.serviceViewController];
    UIImage *serviceNormalImage = [[UIImage imageNamed:@"ic_tab_service_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *serviceSelectedImage = [[UIImage imageNamed:@"ic_tab_service_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceNavigationController.tabBarItem.image = serviceNormalImage;
    serviceNavigationController.tabBarItem.selectedImage = serviceSelectedImage;
    serviceNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    serviceNavigationController.title = @"智能客服";
    
    
    self.meViewController = [[MeViewController alloc] init];
    [self.meViewController viewDidLoad];
    UINavigationController *meNavigationController = [[UINavigationController alloc] initWithRootViewController:self.meViewController];
    
    UIImage *meNormalImage = [UIImage imageNamed:@"ic_tab_me_off"];
    UIImage *meSelectedImage = [UIImage imageNamed:@"ic_tab_me_on"];
    meNavigationController.tabBarItem.image = meNormalImage;
    meNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    meNavigationController.tabBarItem.selectedImage = meSelectedImage;
    meNavigationController.title = @"我的";
    
    self.viewControllers = [NSArray arrayWithObjects:homeNavigationController, serviceNavigationController, meNavigationController, nil];
    
    
    //TabBar设置
    self.tabBar.alpha = 1;
    [self.tabBar setBackgroundColor:I_COLOR_WHITE];
    [self.tabBar setBarTintColor:I_COLOR_WHITE];
    [self.tabBar setTintColor:I_COLOR_BLUE];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       I_COLOR_DARKGRAY, NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:11.0f], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       I_COLOR_BLUE, NSForegroundColorAttributeName,[UIFont systemFontOfSize:11.0f], NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];
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
