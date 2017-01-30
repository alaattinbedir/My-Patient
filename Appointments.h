//
//  Appointments.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/19/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Appointments : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * patientId;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSManagedObject *appointments_patients;

@end
