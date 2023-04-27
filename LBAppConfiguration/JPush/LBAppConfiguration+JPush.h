//
//  LBAppConfiguration+JPush.h
//  YaoHe2.0
//
//  Created by 刘彬 on 2020/11/27.
//

#import "LBAppConfiguration.h"
#import "LBAppConfiguration+Notifications.h"
#import "JPUSHService.h"


NS_ASSUME_NONNULL_BEGIN


@interface LBAppConfiguration (JPush)
/// 快速配置极光推送，只需这一句
/// @param pushKey 极光推送key，必须设置，否则将无法成功注册极光推送
+(void)setJPushKey:(nonnull NSString *)pushKey;
@end

NS_ASSUME_NONNULL_END
