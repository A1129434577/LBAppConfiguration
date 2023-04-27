//
//  HomeViewController.m
//  LBAppConfigurationExample
//
//  Created by 刘彬 on 2021/2/3.
//

#import "HomeViewController.h"
#import "LBAppConfiguration+Login.h"
#import "LBUIMacro.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-80)/2, (CGRectGetHeight(self.view.frame)-50)/2, 80, 50)];
    loginBtn.backgroundColor = [UIColor magentaColor];
    [loginBtn setTitle:[LBAppConfiguration shareInstanse].touristPattern?@"需要登录":@"退出登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(needLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

-(void)needLogin{
    [LBAppConfiguration loginOut];
    
}

@end
