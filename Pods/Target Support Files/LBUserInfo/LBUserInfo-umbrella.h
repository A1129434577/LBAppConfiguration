#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LBUserModel+Location.h"
#import "LBUserModel.h"
#import "LBUserModel+SystemAuth.h"
#import "LBUserModel+TempOperateInfo.h"

FOUNDATION_EXPORT double LBUserInfoVersionNumber;
FOUNDATION_EXPORT const unsigned char LBUserInfoVersionString[];

