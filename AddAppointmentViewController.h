//
//  AddAppointmentViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 12/15/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddAppointmentViewController : GAITrackedViewController{
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) Patients *patient;

@end
