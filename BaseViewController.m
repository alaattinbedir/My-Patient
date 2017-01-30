//
//  BaseViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/20/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)addLogutButton
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL activated = [defaults boolForKey:@"passCode"];
    
    if (activated) {
        UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
        self.navigationItem.leftBarButtonItem = logOutButton;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}


- (void)addPatientButton
{
    UIBarButtonItem *addPatientButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addPatient:)];
    self.navigationItem.rightBarButtonItem = addPatientButton;
}

- (void)addAppointmentButton
{
    UIBarButtonItem *addAppointmentButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addAppointment:)];
    self.navigationItem.rightBarButtonItem = addAppointmentButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"My Patients";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passcodeViewControllerDidFinish:) name:@"LoginSuccesful" object:nil];
}

- (void) addPatient:(id) sender{
    [self performSegueWithIdentifier:@"addPatientSegue" sender:nil];
}

- (void) addAppointment:(id) sender{
    [self performSegueWithIdentifier:@"patientForAppointmetSegue" sender:nil];
}

- (void) logout:(id) sender{

    PasscodeViewController *passcodeViewController = (PasscodeViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Passcode"];

    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (void)passcodeViewControllerDidFinish:(PasscodeViewController *)passcodeViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
