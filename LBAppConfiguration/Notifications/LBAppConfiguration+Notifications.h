//
//  LBAppConfiguration+Notifications.h
//  LBAppConfiguration
//
//  Created by 刘彬 on 2021/2/3.
//

#import "LBAppConfiguration.h"
#import <UserNotifications/UserNotifications.h>


NS_ASSUME_NONNULL_BEGIN

@protocol LBUserNotificationCenterDelegate <UNUserNotificationCenterDelegate>
@optional
/// 配置消息推送（比如设置别名、tag等）
-(void)pushNotificationsConfig;

/// 清空消息推送配置（比如删除别名、tag等）
-(void)cleanPushNotificationsConfig;

/// 前台收到推送消息时的回调
/// @param notificationInfo 消息
-(void)didReceiveRemoteNotification:(nullable NSDictionary *)notificationInfo;

/// 前台收到本地消息时的回调
/// @param notificationInfo 消息
-(void)didReceiveLocalNotification:(nullable NSDictionary *)notificationInfo;

/// 当用户点击推送消息时的回调
/// @param notificationInfo 消息
-(void)handleRemoteNotification:(nullable NSDictionary *)notificationInfo;

/// 当用户点击本地消息时的回调
/// @param notificationInfo 消息
-(void)handleLocalNotification:(nullable NSDictionary *)notificationInfo;
@end


@interface LBAppConfiguration (Notifications)<UNUserNotificationCenterDelegate>

@property (nonatomic, assign) BOOL userRemoteNotificationsOff;//defalut NO，其setter方法同时有关闭和开启系统推送功能

@property (nonatomic, weak) id<LBUserNotificationCenterDelegate> notificationDelegate;//通过设置该delegate快速注册消息推送并初始化默认配置
@end

NS_ASSUME_NONNULL_END
