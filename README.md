# LBAppConfiguration
项目登录模块组件化，免去了一些重复且复杂设置，支持任意第三方推送，支持游客模式，只需要设置LoginController类名以及HomeController类名，内含需要集成的第三方库快速配置，省去了其他一些复杂的代码，一键设置，更快更方便。
# pod安装
```ruby
//全模块
pod 'LBAppConfiguration'
//或者子模块
pod 'LBAppConfiguration', :subspecs => ['Login', 'Notifications','JPush','IQKeyboard','SDWebImage']
```

# 使用方法
```Objc
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    if ([windowScene isKindOfClass:UIWindowScene.class] == NO) {
        return;
    }
    
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
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
    //开始登录，loginInfo为基本用户信息，内部会依据此信息判断是否是已登录状态
    [LBAppConfiguration tryLoginWithNewLoginInfo:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //如果您的项目正好使用极光推送，那么保证您引用了此模块下得极光推送模块下然后设置这两项快速集成
    [LBAppConfiguration shareInstanse].appDelegateClass = self.class;
    [LBAppConfiguration shareInstanse].jpushKey = @"激光推送AppKey";
    
    //设置消息推送的代理（通用）
    [LBAppConfiguration shareInstanse].notificationDelegate = self;
    
    return YES;
}
#pragma mark LBNotificationsDelegate
- (void)pushNotificationsConfig{
    //比如设置激光推送别名
    [JPUSHService setAlias:@"极光推送别名" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    }  seq:1];
}

-(void)cleanPushNotificationsConfig{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:3];
}

-(void)handleNotification:(NSDictionary *)notificationInfo{
    NSLog(@"点击了推送消息");
}
```
