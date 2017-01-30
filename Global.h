//
//  Global.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/25/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patients.h"

@interface Global : NSObject{
    NSMutableDictionary *patientsDictionary;
    NSMutableArray *patientsArray;
    NSMutableArray *appointmentsArray;
}

+ (Global*)sharedInstance;
-(NSMutableArray *) keysOfPatients:(NSMutableArray *) patients;
-(NSMutableDictionary *) sectionOfPatients:(NSMutableArray *) patients;
-(void)showErrorMessageWithText:(NSString*)text;
-(void)showInfoMessageWithText:(NSString*)text;


@property (copy,readwrite) NSMutableDictionary *patientsDictionary;
@property (nonatomic, strong) NSMutableArray *patientsArray;
@property (nonatomic, strong) NSMutableArray *appointmentsArray;


/**
 initilization for global arrays
 */
- (id)init;

@end
