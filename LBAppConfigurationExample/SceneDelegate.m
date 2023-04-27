//
//  SceneDelegate.m
//  AllTestDemo
//
//  Created by 刘彬 on 2023/4/26.
//

#import "SceneDelegate.h"
#import "LBAppConfiguration+Login.h"

@interface SceneDelegate  ()

@end

NS_AVAILABLE_IOS(13_0)
@implementation SceneDelegate 


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    NSLog(@"场景加载完成");

    //ios13在SceneDelegate中不使用storyboard创建
    if (@available(iOS 13.0, *)) {
        if (scene) {
            //初始化 window 对象
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
            self.window.frame = windowScene.coordinateSpace.bounds;
            [self.window makeKeyAndVisible];
            
            //开始登录，loginInfo为基本用户信息，内部会依据此信息判断是否是已登录状态
            [LBAppConfiguration tryLoginWithNewLoginInfo:nil];
        }
    } else {
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    NSLog(@"场景已经断开连接");
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    NSLog(@"已经从后台进入前台");
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"即将从前台进入后台");
}


- (void)sceneWillEnterForeground:(UIScene *)scene  {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    NSLog(@"即将从后台进入前台");
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    NSLog(@"已经从前台进入后台");
}


@end
