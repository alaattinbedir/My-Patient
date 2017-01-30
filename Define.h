//
//  Define.h
//  KPI
//
//  Created by Alaattin Bedir on 4/17/13.
//  Copyright (c) 2013 Jaludo BV. All rights reserved.
//


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)

#define IPHONE_NORMAL (IS_IPHONE && !IS_RETINA)
#define IPHONE_RETINA (IS_IPHONE && IS_RETINA)
#define IPAD_NORMAL   (IS_IPAD && !IS_RETINA)
#define IPAD_RETINA   (IS_IPAD && IS_RETINA)

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define JALocalizedString(key, comment) \
[key localizedString]

#define JALocalizedColor(key, comment) \
NSLocalizedStringFromTable(key, @"Colors", comment)

#define PROFILE_IMAGE_BORDER_WIDTH 1
#define PROFILE_IMAGE_CORNER_RADIUS 0.0f
#define PROFILE_IMAGE_BORDER_COLOR  [UIColor colorWithR:76 G:76 B:76 A:1].CGColor
#define PROFILE_IMAGE_BADGE_INSET_COLOR    [UIColor colorWithR:131 G:0 B:0 A:1]
#define PROFILE_IMAGE_BADGE_FRAME_COLOR    [UIColor whiteColor]
#define TIME_LABEL_TEXTCOLOR    [UIColor colorWithR:84 G:84 B:84 A:1]
#define TIME_LABEL_BACKGROUNDCOLOR   [UIColor clearColor]

#define SCREEN_BACKGROUNDCOLOR  [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgpattern.png"]]



