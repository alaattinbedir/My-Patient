//
//  UIFont+Addition.m
//  T4CCommon
//
//  Created by Fatih YASAR on 3/5/13.
//
//

#import "UIFont+Addition.h"

@implementation UIFont (Addition)

+(NSString*)currentFontName{
    return @"Helvetica";
}
+(NSString*)currentBoldFontName{
    return @"Helvetica-Bold";
}
+(UIFont*)extraSmallFont{
    return [UIFont fontWithSize:10];
}
+(UIFont*)smallerFont{
    return [UIFont fontWithSize:13];
}
+(UIFont*)smallFont{
    return [UIFont fontWithSize:15];
}

+(UIFont*)mediumFont{
    return [UIFont fontWithSize:18];
}



+(UIFont*)extraSmallBoldFont{
    return [UIFont boldFontWithSize:13];
}

+(UIFont*)smallBoldFont{
    return [UIFont boldFontWithSize:15];
}


+(UIFont*)mediumBoldFont{
    return [UIFont boldFontWithSize:18];
}
+(UIFont*)largeBoldFont{
    return [UIFont boldFontWithSize:20];
}

+(UIFont *)boldFontWithSize:(int)size{
    UIFont *font=[UIFont fontWithName:[UIFont currentBoldFontName] size:size];
    return font;
}
+(UIFont *)fontWithSize:(int)size{
    UIFont *font=[UIFont fontWithName:[UIFont currentFontName] size:size];
    return font;
}

@end
