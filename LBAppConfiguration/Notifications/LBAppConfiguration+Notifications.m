//
//  LBAppConfiguration+Notifications.m
//  LBAppConfiguration
//
//  Created by 刘彬 on 2021/2/3.
//

#import "LBAppConfiguration+Notifications.h"
#import <objc/runtime.h>

static NSString *LBUserRemoteNotificationsSwitchOffKey = @"LBUserRemoteNotificationsSwitchOffKey";

static NSString *LBUserNotificationCenterDelegateKey = @"LBUserNotificationCenterDelegateKey";


@implementation LBAppConfiguration (Notifications)

- (void)setUserRemoteNotificationsOff:(BOOL)userRemoteNotificationsOff{
    
    [[NSUserDefaults standardUserDefaults] setBool:userRemoteNotificationsOff forKey:LBUserRemoteNotificationsSwitchOffKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (userRemoteNotificationsOff) {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
    else{
        if ([UIApplication sharedApplication].registeredForRemoteNotifications == NO) {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
}
- (BOOL)userRemoteNotificationsOff{
    return [[NSUserDefaults standardUserDefaults] boolForKey:LBUserRemoteNotificationsSwitchOffKey];
}

-(id<LBUserNotificationCenterDelegate>)notificationDelegate{
    return objc_getAssociatedObject(self, &LBUserNotificationCenterDelegateKey);
}

-(void)setNotificationDelegate:(id<LBUserNotificationCenterDelegate>)notificationDelegate{
    objc_setAssociatedObject(self, &LBUserNotificationCenterDelegateKey, notificationDelegate, OBJC_ASSOCIATION_ASSIGN);
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    notificationCenter.delegate = self;//必须写代理，不然无法监听通知的接收与点击事件
    
    //可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置（之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API）。
    [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge|
                                                     UNAuthorizationOptionSound|
                                                     UNAuthorizationOptionAlert)
                                  completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
            }];
        }
    }];
    
    if (self.userRemoteNotificationsOff == NO) {
        if ([UIApplication sharedApplication].registeredForRemoteNotifications == NO) {
            [[UIApplication sharedApplication] registerForRemoteNotifications];//注册远端消息通知获取device token
        }
    }
}

#pragma mark UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary * userInfo= notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        if ([self.notificationDelegate respondsToSelector:@selector(didReceiveRemoteNotification:)]) {
            [self.notificationDelegate didReceiveRemoteNotification:userInfo];
        }
    }else{
        if ([self.notificationDelegate respondsToSelector:@selector(didReceiveLocalNotification:)]) {
            [self.notificationDelegate didReceiveLocalNotification:userInfo];
        }
    }
    
    if ([self.notificationDelegate respondsToSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
        [self.notificationDelegate userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
    }else{
        completionHandler(UNNotificationPresentationOptionBadge|
                          UNNotificationPresentationOptionSound|
                          UNNotificationPresentationOptionAlert);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    NSDictionary * userInfo= response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        if ([self.notificationDelegate respondsToSelector:@selector(handleRemoteNotification:)]) {
            [self.notificationDelegate handleRemoteNotification:userInfo];
        }
    }else{
        if ([self.notificationDelegate respondsToSelector:@selector(handleLocalNotification:)]) {
            [self.notificationDelegate handleLocalNotification:userInfo];
        }
    }
    
    
    
    if ([self.notificationDelegate respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
        [self.notificationDelegate userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
    }else{
        completionHandler();
    }
    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification{
    if ([self.notificationDelegate respondsToSelector:@selector(userNotificationCenter:openSettingsForNotification:)]) {
        if (@available(iOS 12.0, *)) {
            [self.notificationDelegate userNotificationCenter:center openSettingsForNotification:notification];
        }
    }
}
@end
