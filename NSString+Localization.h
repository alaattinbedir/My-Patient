
#import <Foundation/Foundation.h>

@interface NSString (Localization)


-(NSString*)localizedString;
+(NSString*)currentLocalizationCode;
+(NSString*)findPreferredLanguageCode;

@end
