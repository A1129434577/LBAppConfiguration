//
//  LBAppConfiguration.m
//  TestDome
//
//  Created by 刘彬 on 2020/10/16.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "LBAppConfiguration.h"

@implementation LBAppConfiguration
+(LBAppConfiguration *)shareInstanse{
    static LBAppConfiguration *configuration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [[super alloc] init];
    });
    return configuration;
}

@end
