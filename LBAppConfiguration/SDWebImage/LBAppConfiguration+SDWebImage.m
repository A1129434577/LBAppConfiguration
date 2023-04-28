//
//  LBAppConfiguration+SDWebImage.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+SDWebImage.h"
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>

@implementation LBAppConfiguration (SDWebImage)
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SDWebImage_ApplicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
}
+(void)SDWebImage_ApplicationDidFinishLaunching{
    //iOS14以下系统不支持webP的图片格式，需要植入webP格式支持
    SDImageWebPCoder *webPCoder = [SDImageWebPCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:webPCoder];
}
@end
