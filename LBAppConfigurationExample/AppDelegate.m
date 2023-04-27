//
//  AppDelegate.m
//  AllTestDemo
//
//  Created by 刘彬 on 2023/4/26.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "LBAppConfiguration+JPush.h"
#import "LBAppConfiguration+Login.h"


@interface AppDelegate ()<LBUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //设置消息推送的代理（本地和远程推送通用）
    [LBAppConfiguration shareInstanse].notificationDelegate = self;

    //如果您的项目正好使用极光推送，那么可以这样设置快速集成极光推送
    [LBAppConfiguration setJPushKey:@"08d54656edf68d60e50629c0"];

    //设置登录控制器类
    [LBAppConfiguration shareInstanse].loginVCClass = LoginViewController.class;
    //如果需要设置登录导航控制器类
    [LBAppConfiguration shareInstanse].loginNaVCClass = UINavigationController.class;
    //设置主界面类
    [LBAppConfiguration shareInstanse].homeVCClass = TabBarViewController.class;
    //如果需要设置主界面导航控制器类
    //[LBAppConfiguration shareInstanse].homeVCNaClass = UINavigationController.class;
    //是否支持游客模式
    [LBAppConfiguration shareInstanse].touristPattern = YES;
    
    if(@available(iOS 13, *)){
        
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window makeKeyAndVisible];
        
        //开始登录，loginInfo为基本用户信息，内部会依据此信息判断是否是已登录状态
        [LBAppConfiguration tryLoginWithNewLoginInfo:nil];
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options NS_AVAILABLE_IOS(13_0) {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    //在 iOS13 之前的版本需要做版本控制
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    } else {
        return nil;
    }
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions NS_AVAILABLE_IOS(13_0) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    if (@available(iOS 13.0, *)) {
        //在分屏中关闭其中一个或多个scene时候会调用。
        NSLog(@"%s",__func__);
    } else {
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}

#pragma mark LBNotificationsDelegate
- (void)pushNotificationsConfig{
    //比如设置激光推送别名
    [JPUSHService setAlias:@"1129434577" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

    }  seq:1];
}

-(void)cleanPushNotificationsConfig{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

    } seq:3];
}

-(void)didReceiveRemoteNotification:(NSDictionary *)notificationInfo{
    NSLog(@"收到推送消息");
}

-(void)handleRemoteNotification:(NSDictionary *)notificationInfo{
    NSLog(@"点击了推送消息");
}

@end
