//
//  FMConfigure.h
//  mogi
//
//  Created by cherry on 15/8/12.
//  Copyright (c) 2015年 com.8w4q. All rights reserved.
//

#import "AutoLayoutHeader.h"

#ifndef mogi_FMConfigure_h
#define mogi_FMConfigure_h


#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//#define VERSION @"2.0"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) 
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define URL @""


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBALPHA(rgbValue,alphaNum) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaNum]

//统默认字体
#define SYS_FONT(x) [UIFont systemFontOfSize:x]
#define NUM_SYS_FONT(x) [UIFont systemFontOfSize:x]
#define LIGHT_FONT(x) [UIFont fontWithName:@"STHeitiSC-Light" size:x]
#define LIGHTMEDIUM_FONT(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]
//navi title的字体
#define NAVI_FONT(x) [UIFont fontWithName:@"STHeitiSC-Medium" size:x]
#define NUM_FONT(x) [UIFont fontWithName:@"HelveticaNeueLT-Condensed" size:x]
//登陆界面隶书
#define LOGIN_FONT(x) [UIFont fontWithName:@"FZTieJinLiShu-S17S" size:x]

#define HELV_FONT(x)  [UIFont fontWithName:@"HelveticaNeue LT 57 Cn" size:x]

//隐私默认值
#define FM_DEFAULT_PRIVACY YES


//ios系统版本
#define ios9x [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f && ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0f)
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f && ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
#define iosNot5x [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f
#define ios5x [[[UIDevice currentDevice] systemVersion] floatValue] < 6.0f


#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

#define iphone6_4_7UP ([UIScreen mainScreen].bounds.size.height>=667.0f)


#endif
