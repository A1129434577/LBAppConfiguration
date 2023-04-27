//
//  TabBarViewController.m
//  LBAppConfigurationExample
//
//  Created by 刘彬 on 2021/2/3.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.tintColor = [UIColor blackColor];
        self.tabBar.unselectedItemTintColor = [UIColor grayColor];
        
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.tabBarItem.title = @"首页";
        UINavigationController *homeNaVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
        
        self.viewControllers = @[homeNaVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
