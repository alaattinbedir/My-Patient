//
//  AddAppointmentViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 12/15/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "AddAppointmentViewController.h"
#import "Appointments.h"


@interface AddAppointmentViewController ()

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTeextField;
@property (strong, nonatomic) IBOutlet UITextField *appointmentDateTextField;
@property (strong, nonatomic) IBOutlet UITextField *noteTextField;

@property (strong, nonatomic) IBOutlet UITextField *timeTextField;
@end

@implementation AddAppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)addAppintmentButton
{
    UIBarButtonItem *saveAppointmentButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAppointment:)];
    self.navigationItem.rightBarButtonItem = saveAppointmentButton;
}


- (void)saveAppointment:(id) sender{
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Appointments *appointment = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Appointments"
                          inManagedObjectContext:context];
    
    appointment.name =  self.firstNameTextField.text;
    appointment.date = self.appointmentDateTextField.text;
    appointment.time = self.timeTextField.text;
    appointment.note = self.noteTextField.text;
    appointment.patientId = self.patient.pid;
    appointment.status = [NSNumber numberWithInt:0];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [[Global sharedInstance] showInfoMessageWithText:JALocalizedString(@"KEY68",nil)];
    
    [self hideKeyboard];
    [self clear];
    
    appDelegate.isReloadAppointments = YES;
    [appDelegate SetAppointmentsList];
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)clear {
    self.firstNameTextField.text = @"";
    self.lastNameTeextField.text = @"";
    self.noteTextField.text = @"";
    self.timeTextField.text = @"";
    self.appointmentDateTextField.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAppintmentButton];
    
    self.firstNameTextField.text = self.patient.firstName;
    self.lastNameTeextField.text = self.patient.lastName;
    
    UIDatePicker *appointmentDatePicker = [[UIDatePicker alloc]init];
    [appointmentDatePicker setDatePickerMode:UIDatePickerModeDate];
    [appointmentDatePicker setDate:[NSDate date]];
    [appointmentDatePicker addTarget:self action:@selector(updateAppointmentDate:) forControlEvents:UIControlEventValueChanged];
    [self.appointmentDateTextField setInputView:appointmentDatePicker];

    UIDatePicker *appointmentTimePicker = [[UIDatePicker alloc]init];
    [appointmentTimePicker setDatePickerMode:UIDatePickerModeTime];
    [appointmentTimePicker setDate:[NSDate date]];
    [appointmentTimePicker addTarget:self action:@selector(updateAppointmentTime:) forControlEvents:UIControlEventValueChanged];
    [self.timeTextField setInputView:appointmentTimePicker];

    
}

-(void)updateAppointmentDate:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.appointmentDateTextField.inputView;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    
    // Reduce event start date to date components (year, month, day)
    NSString *appointmentDate = [df stringFromDate:picker.date];
    self.appointmentDateTextField.text = appointmentDate;
}

-(void)updateAppointmentTime:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.timeTextField.inputView;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    
    // Reduce event start date to date components (year, month, day)
    NSString *appointmentDate = [df stringFromDate:picker.date];
    self.timeTextField.text = appointmentDate;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
