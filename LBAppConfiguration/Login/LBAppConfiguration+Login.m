//
//  LBAppConfiguration+Login.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+Login.h"
#import <objc/runtime.h>
#import <LBCommonComponents/LBUIMacro.h>
#import <LBCommonComponents/NSObject+LBTopViewController.h>

static NSString *LBTouristPatternKey = @"LBTouristPatternKey";
static NSString *LBModalPresentationStyleKey = @"LBModalPresentationStyleKey";


@implementation LBAppConfiguration (Login)
+(void)tryLoginWithNewLoginInfo:(NSDictionary<LBUserModelKey,id> *)newInfo{
    if (newInfo) {
        //保存账号和token
        [[LBUserModel shareInstanse] setLBUserInfoObject:newInfo[LBToken] forKey:LBToken];
        [[LBUserModel shareInstanse] setLBUserInfoObject:newInfo[LBAccount] forKey:LBAccount];
    }
    
    if ([[self shareInstanse].notificationDelegate respondsToSelector:@selector(pushNotificationsConfig)]) {
        [[self shareInstanse].notificationDelegate pushNotificationsConfig];
    }
    
    if ([self shareInstanse].touristPattern) {
        UIViewController *loginVC = [self findLoginViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController];
        if (loginVC.navigationController) {
            loginVC = loginVC.navigationController;
        }
        if (loginVC.presentingViewController) {
            loginVC = loginVC.presentingViewController;
        }
        if (loginVC) {
            [loginVC dismissViewControllerAnimated:YES completion:NULL];
        }else{
            if ([self shareInstanse].homeNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].homeVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeVCClass alloc] init];
            }
        }
    }
    else{
        if ([LBUserModel shareInstanse].userInfo[LBToken] &&
            [LBUserModel shareInstanse].userInfo[LBAccount]) {//复用此token（免登陆）
            if ([self shareInstanse].homeNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].homeVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].homeVCClass alloc] init];
            }
        }else{
            if ([self shareInstanse].loginNaVCClass) {
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].loginNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
            }else{
                LB_KEY_WINDOW.rootViewController = [[[self shareInstanse].loginVCClass alloc] init];
            }
        }
    }
    
}

+(void)loginOut{
    UIViewController *loginVC;
    if ([self shareInstanse].loginNaVCClass) {
        loginVC = [[[self shareInstanse].loginNaVCClass alloc] initWithRootViewController:[[[self shareInstanse].loginVCClass alloc] init]];
    }else{
        loginVC = [[[self shareInstanse].loginVCClass alloc] init];
    }
    if ([self shareInstanse].touristPattern) {
        UIViewController *topVC = [UIViewController topViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController];
        if (![topVC isKindOfClass:[self shareInstanse].loginVCClass]) {
            loginVC.modalPresentationStyle = (topVC.modalPresentationStyle==UIModalPresentationCustom)?UIModalPresentationCustom:[self shareInstanse].modalPresentationStyle;
            [topVC presentViewController:loginVC animated:YES completion:NULL];
            loginVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:[self shareInstanse] action:@selector(touristLoginCancel)];
        }
    }else{
        LB_KEY_WINDOW.rootViewController = loginVC;
    }
    
}

+(void)loginOutHoldBackAccount{
    [self cleanUserInfoHoldBackAccount:YES];
    [self loginOut];
}

+ (void)loginOutCleanUserInfo{
    [self cleanUserInfoHoldBackAccount:NO];
    [self loginOut];
}

+(void)cleanUserInfoHoldBackAccount:(BOOL)holdBackAccount{
    [self cleanPushNotificationsConfig];//调用清除推送配置
    if (holdBackAccount) {
        //移除用户数据并保留登录账号
        NSString *account = [LBUserModel shareInstanse].userInfo[LBAccount];
        [[LBUserModel shareInstanse] removeUserInfo];
        [[LBUserModel shareInstanse] setLBUserInfoObject:account forKey:LBAccount];
    }else{
        //移除用户数据
        [[LBUserModel shareInstanse] removeUserInfo];
    }
}

/// 删除推送设置
+(void)cleanPushNotificationsConfig{
    if ([[self shareInstanse].notificationDelegate respondsToSelector:@selector(cleanPushNotificationsConfig)]) {
        [[self shareInstanse].notificationDelegate cleanPushNotificationsConfig];
    }
}

+ (UIViewController *)findLoginViewControllerWithRootViewController:(UIViewController *)rootVC
{
    if ([rootVC isKindOfClass:[self shareInstanse].loginVCClass]) {
        return rootVC;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController*)rootVC;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)rootVC;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:(UIViewController *)navigationController.topViewController];
    } else if (rootVC.presentedViewController) {
        UIViewController *presentedViewController = (UIViewController *)rootVC.presentedViewController;
        return (UIViewController *)[self findLoginViewControllerWithRootViewController:presentedViewController];
    } else {
        return nil;
    }
}

-(void)touristLoginCancel{
    [[UIViewController topViewControllerWithRootViewController:LB_KEY_WINDOW.rootViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)touristPattern{
    return [objc_getAssociatedObject(self, &LBTouristPatternKey) boolValue];
}
- (void)setTouristPattern:(BOOL)touristPattern{
    objc_setAssociatedObject(self, &LBTouristPatternKey, @(touristPattern), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIModalPresentationStyle)modalPresentationStyle{
    return [objc_getAssociatedObject(self, &LBModalPresentationStyleKey) integerValue];
}
- (void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    objc_setAssociatedObject(self, &LBModalPresentationStyleKey, @(modalPresentationStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
