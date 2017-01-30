//
//  Global.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/25/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "Global.h"

@implementation Global
@synthesize patientsDictionary,patientsArray;

+ (Global*)sharedInstance
{
    static Global *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Global alloc] init];
        
    });
    return sharedInstance;
}

/** initilization for global arrays
 */
- (id)init {
    if (self = [super init]) {
        patientsDictionary = [NSMutableDictionary new];
        patientsArray = [NSMutableArray new];
        appointmentsArray = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc
{
    // implement -dealloc & remove abort() when refactoring for
    // non-singleton use.
    abort();
}

-(NSMutableDictionary *) sectionOfPatients:(NSMutableArray *) contacts{
    //NSLog(@"Section of contact list entered!");
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *tempLetter = nil;
    for(int i=0; i<[contacts count]; i++)
    {
        Patients *patient = (Patients *)[contacts objectAtIndex:i];
        NSString *firstLetter;
        if ([patient.firstName length] > 0) {
            firstLetter = [[patient.firstName substringToIndex:1] capitalizedString];
        }else
            continue;

        if([firstLetter isEqualToString:tempLetter])
            continue;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName beginswith[c] %@", firstLetter];
        NSArray *letters = [contacts filteredArrayUsingPredicate:predicate];
        
        [dict setObject:letters forKey:firstLetter];
    }
    return dict;
}

-(NSMutableArray *) keysOfPatients:(NSMutableArray *) contacts{
    //NSLog(@"Keys of contact list entered!");
    
    NSMutableArray *section = [NSMutableArray array];
    NSString *tempLetter = nil;
    for(int i=0; i<[contacts count]; i++)
    {
        Patients *patient = (Patients *)[contacts objectAtIndex:i];

        NSString *firstLetter;
        if ([patient.firstName length] > 0) {
            firstLetter = [[patient.firstName substringToIndex:1] capitalizedString];
        }else
            continue;
        
        if([firstLetter isEqualToString:tempLetter])
            continue;
        
        tempLetter = firstLetter;
        [section addObject:firstLetter];
    }
    
    return section;
}

/** Shows error message
 */
-(void)showErrorMessageWithText:(NSString*)text{
    [[[UIAlertView alloc]initWithTitle:JALocalizedString(@"KEY65", nil)
                               message:text delegate:nil
                     cancelButtonTitle:JALocalizedString(@"KEY66", nil)
                     otherButtonTitles:nil]show];
}

/** Shows info message
 */
-(void)showInfoMessageWithText:(NSString*)text{
    [[[UIAlertView alloc]initWithTitle:JALocalizedString(@"KEY64", nil)
                               message:text delegate:nil
                     cancelButtonTitle:JALocalizedString(@"KEY66", nil)
                     otherButtonTitles:nil]show];
}

@end
