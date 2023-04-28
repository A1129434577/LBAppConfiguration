//
//  LBAppConfiguration+IQKeyboard.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration+IQKeyboard.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation LBAppConfiguration (IQKeyboard)
+(void)load{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IQKeyboard_ApplicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
}
+(void)IQKeyboard_ApplicationDidFinishLaunching{
    //键盘
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
