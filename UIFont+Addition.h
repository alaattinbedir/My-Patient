//
//  UIFont+Addition.h
//  T4CCommon
//
//  Created by Fatih YASAR on 3/5/13.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (Addition)

+(UIFont*)extraSmallFont; // 10px
+(UIFont*)smallerFont; // 13 px
+(UIFont*)smallFont; // 15px
+(UIFont*)mediumFont; // 18 px



+(UIFont*)extraSmallBoldFont;
+(UIFont*)smallBoldFont;
+(UIFont*)mediumBoldFont;
+(UIFont*)largeBoldFont;

+(NSString*)currentBoldFontName;
+(NSString*)currentFontName;
@end
