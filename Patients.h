//
//  Patients.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/19/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Appointments;

@interface Patients : NSManagedObject

@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * admissionDate;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSString * complaints;
@property (nonatomic, retain) NSString * dateOfBirth;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * emergencyNo;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * pid;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSData * smallPhoto;
@property (nonatomic, retain) NSString * timeSpent;
@property (nonatomic, assign) BOOL  deleted;
@property (nonatomic, retain) Appointments *patients_appointments;

@end
