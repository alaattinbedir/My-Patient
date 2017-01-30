//
//  BaseViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/20/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPatientViewController.h"
#import "GAITrackedViewController.h"
#import "PasscodeViewController.h"

@interface BaseViewController : GAITrackedViewController


- (void)addLogutButton;
- (void)addAppointmentButton;
- (void)addPatientButton;
- (void)addPatient:(id) sender;
- (void)logout:(id) sender;
- (void)passcodeViewControllerDidFinish:(PasscodeViewController *)passcodeViewController;

@end
