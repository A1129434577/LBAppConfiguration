//
//  LBAppConfiguration+JPush.m
//  YaoHe2.0
//
//  Created by 刘彬 on 2020/11/27.
//

#import "LBAppConfiguration+JPush.h"
#import <LBCommonComponents/NSObject+LBMethodSwizzling.h>

#ifdef DEBUG
#define JPUSH_TYPE 0
#else
#define JPUSH_TYPE 1
#endif

static BOOL appDelegateRespondsToSelectorDidRegisterForRemoteNotificationsWithDeviceToken = NO;

@implementation LBAppConfiguration (JPush)
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JPush_ApplicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JPush_ApplicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}
+(void)JPush_ApplicationDidFinishLaunching:(NSNotification *)notification{
    [self JPush_ApplicationWillEnterForeground];
}

+(void)JPush_ApplicationWillEnterForeground{
    //清空消息通知数量提醒
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

+ (void)setJPushKey:(NSString *)pushKey {
    //在交换之前判断AppDelegate是否实现didRegisterForRemoteNotificationsWithDeviceToken方法
    appDelegateRespondsToSelectorDidRegisterForRemoteNotificationsWithDeviceToken = [[UIApplication sharedApplication].delegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)];
    //交换didRegisterForRemoteNotificationsWithDeviceToken方法来设置极光[JPUSHService registerDeviceToken:deviceToken]
    [NSObject lb_swizzleMethodClass:[UIApplication sharedApplication].delegate.class
                         method:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)
          originalIsClassMethod:NO
                      withClass:self
                     withMethod:@selector(JPush_application:didRegisterForRemoteNotificationsWithDeviceToken:)
          swizzledIsClassMethod:NO];
    
    
    //推送通知配置
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    [notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge|
                                                     UNAuthorizationOptionSound|
                                                     UNAuthorizationOptionAlert)
                                  completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
            }];
        }
    }];
    
    //配置极光推送
    [JPUSHService setupWithOption:nil
                           appKey:pushKey
                          channel:@"App Store"
                 apsForProduction:JPUSH_TYPE];
    
    //注册一次保证didRegisterForRemoteNotificationsWithDeviceToken回调的执行
    if ([LBAppConfiguration shareInstanse].userRemoteNotificationsOff == NO) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];//注册远端消息通知获取device token
    }
}


- (void)JPush_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (appDelegateRespondsToSelectorDidRegisterForRemoteNotificationsWithDeviceToken) {
        [self JPush_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


@end
