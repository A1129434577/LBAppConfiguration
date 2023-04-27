//
//  ViewController.m
//  LBAppConfigurationExample
//
//  Created by 刘彬 on 2020/10/16.
//

#import "LoginViewController.h"
#import "LBAppConfiguration+Login.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor cyanColor];
    
    if ([LBAppConfiguration shareInstanse].touristPattern) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(loginCancel)];
    }
    
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-80)/2, CGRectGetHeight(self.view.frame)-50-80, 80, 50)];
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setTitle:@"开始登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}
-(void)loginCancel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)login{
    [LBAppConfiguration tryLoginWithNewLoginInfo:nil];
}
@end
