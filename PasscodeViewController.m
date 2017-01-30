//
//  PasscodeViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 5/20/14.
//  Copyright (c) 2014 Alaattin Bedir. All rights reserved.
//

#import "PasscodeViewController.h"

@interface PasscodeViewController ()

@end

@implementation PasscodeViewController
@synthesize delegate;
@synthesize passcodeFour;
@synthesize passcodeOne;
@synthesize passcodeTwo;
@synthesize passcodeThree;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark TextField Delagate Methods


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL shouldProcess = NO; //default to reject
    BOOL shouldMoveToNextField = NO; //default to remaining on the current field
    
    int insertStringLength = [string length];
    if(insertStringLength == 0){ //backspace
        shouldProcess = YES; //Process if the backspace character was pressed
    }
    else {
        if([[textField text] length] == 0) {
            shouldProcess = YES; //Process if there is only 1 character right now
        }
    }
    
    //here we deal with the UITextField on our own
    if(shouldProcess){
        //grab a mutable copy of what's currently in the UITextField
        NSMutableString* mstring = [[textField text] mutableCopy];
        if([mstring length] == 0){
            //nothing in the field yet so append the replacement string
            [mstring appendString:string];
            
            shouldMoveToNextField = YES;
        }
        else{
            //adding a char or deleting?
            if(insertStringLength > 0){
                [mstring insertString:string atIndex:range.location];
            }
            else {
                //delete case - the length of replacement string is zero for a delete
                [mstring deleteCharactersInRange:range];
            }
        }
        
        //set the text now
        [textField setText:mstring];
        
        if (shouldMoveToNextField) {
            
            switch (textField.tag) {
                case 1:
                    [self.passcodeTwo becomeFirstResponder];
                    break;
                case 2:
                    [self.passcodeThree becomeFirstResponder];
                    break;
                case 3:
                    [self.passcodeFour becomeFirstResponder];
                    break;
                case 4:{
                    
                    NSString *one = [defaults objectForKey:@"passCodeOne"];
                    NSString *two = [defaults objectForKey:@"passCodeTwo"];
                    NSString *three = [defaults objectForKey:@"passCodeThree"];
                    NSString *four = [defaults objectForKey:@"passCodeFour"];
                    BOOL authenticated = false;
                    
                    if (one == nil && two == nil && three == nil && four == nil) {
                        
                        [defaults setObject:self.passcodeOne.text forKey:@"passCodeOne"];
                        [defaults setObject:self.passcodeTwo.text forKey:@"passCodeTwo"];
                        [defaults setObject:self.passcodeThree.text forKey:@"passCodeThree"];
                        [defaults setObject:self.passcodeFour.text forKey:@"passCodeFour"];
                        
                        [defaults synchronize];
                        authenticated = true;
                    }
                    
                    if (one != nil && [self.passcodeOne.text isEqualToString:one] &&
                        two != nil && [self.passcodeTwo.text isEqualToString:two] &&
                        three != nil && [self.passcodeThree.text isEqualToString:three] &&
                        four != nil && [self.passcodeFour.text isEqualToString:four]) {
                        
                        authenticated = true;
                    }
                    
                    if(authenticated){
                        [self.delegate passcodeViewControllerDidFinish:self];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccesful" object:nil];
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                        message:@"Passcode failed!"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        self.passcodeOne.text = @"";
                        self.passcodeTwo.text = @"";
                        self.passcodeThree.text = @"";
                        self.passcodeFour.text = @"";
                        
                        [self.passcodeOne becomeFirstResponder];
                    }

                }
                    break;
                default:
                    break;
            }
            
        }
    }
    
    //always return no since we are manually changing the text field
    return NO;
}

#pragma mark -
#pragma mark LifeCycle

-(void) Cancel:(id)sender{
    [self.delegate passcodeViewControllerDidFinish:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccesful" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];


    self.navigationItem.title = @"My Patients";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    
    CGRect frameOne = self.passcodeOne.frame;
    frameOne.size.height = 50;
    self.passcodeOne.frame = frameOne;
    [self.passcodeOne setTextAlignment:NSTextAlignmentCenter];
    [self.passcodeOne setFont:[UIFont systemFontOfSize:25]];
    [self.passcodeOne setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passcodeOne setTag:1];
    [self.passcodeOne setDelegate:self];

    CGRect frameTwo= self.passcodeTwo.frame;
    frameTwo.size.height = 50;
    self.passcodeTwo.frame = frameTwo;
    [self.passcodeTwo setTextAlignment:NSTextAlignmentCenter];
    [self.passcodeTwo setFont:[UIFont systemFontOfSize:25]];
    [self.passcodeTwo setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passcodeTwo setTag:2];
    [self.passcodeTwo setDelegate:self];
    
    CGRect frameThree= self.passcodeThree.frame;
    frameThree.size.height = 50;
    self.passcodeThree.frame = frameThree;
    [self.passcodeThree setTextAlignment:NSTextAlignmentCenter];
    [self.passcodeThree setFont:[UIFont systemFontOfSize:25]];
    [self.passcodeThree setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passcodeThree setTag:3];
    [self.passcodeThree setDelegate:self];

    CGRect frameFour = self.passcodeFour.frame;
    frameFour.size.height = 50;
    self.passcodeFour.frame = frameFour;
    [self.passcodeFour setTextAlignment:NSTextAlignmentCenter];
    [self.passcodeFour setFont:[UIFont systemFontOfSize:25]];
    [self.passcodeFour setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passcodeFour setTag:4];
    [self.passcodeFour setDelegate:self];
    
    [self.view addSubview:self.passcodeFour];
    [self.view addSubview:self.passcodeOne];
    [self.view addSubview:self.passcodeTwo];
    [self.view addSubview:self.passcodeThree];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *one = [defaults objectForKey:@"passCodeOne"];
    NSString *two = [defaults objectForKey:@"passCodeTwo"];
    NSString *three = [defaults objectForKey:@"passCodeThree"];
    NSString *four = [defaults objectForKey:@"passCodeFour"];
    
    if (one != nil && two != nil && three != nil && four != nil) {
        [self.setPasscodeLabel setHidden:YES];
    }
    
    //UINavigationBar *myBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    //[self.view addSubview:myBar];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
