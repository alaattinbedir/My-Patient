

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Extras)

+ (UIColor*)colorWithHexString:(NSString*)hex;

/** 
 UIColor for hex
 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

+ (UIColor*)cellTextColor;
    
@end
