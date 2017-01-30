//
//  PatientDetailViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/26/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "PatientDetailViewController.h"

@interface PatientDetailViewController ()

@end

@implementation PatientDetailViewController

@synthesize patient,photoImageView;




#pragma -
#pragma Viewcontroller life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.scrollView setBackgroundColor:[UIColor colorWithR:248 G:248 B:248 A:1]];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, 600)];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        self.automaticallyAdjustsScrollViewInsets = NO;

    [self.photoImageView.layer setCornerRadius:10.0f];
    [self.photoImageView.layer setMasksToBounds:YES];
    [self.photoImageView.layer setBorderWidth:1.0f];
    [self.photoImageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.photoImageView.userInteractionEnabled = YES;
    
    if(patient.smallPhoto.length > 0)
        self.photoImageView.image = [UIImage imageWithData:patient.smallPhoto];
    else
        self.photoImageView.image = [UIImage imageNamed:@"picturePlageHolder.png"];
        
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;

    self.patientName.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    NSString *gender = [patient.gender intValue] == 1 ? JALocalizedString(@"KEY73", nil) : JALocalizedString(@"KEY74", nil);
    
    self.patientGender.text = gender;
    self.birthdate.text = patient.dateOfBirth;
    self.admissionDate.text = patient.admissionDate;
    self.email.text = patient.email;
    self.phone.text = patient.phone;
    self.address.text = patient.address;
    self.comments.text = patient.comments;
    self.complaints.text = patient.complaints;
    self.emergencyNo.text = patient.emergencyNo;
    
    UITapGestureRecognizer *photoTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [photoTapGesture setNumberOfTapsRequired:1];
    [self.photoImageView addGestureRecognizer:photoTapGesture];
    
    [self.scrollView addSubview:self.photoImageView];
}

- (void )imageTapped:(UIGestureRecognizer*)gesturerecogniser
{
    //    NSLog(@"%@", self..contactId);
    
    // Create image picker controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
	imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    // Delegate is self
	imagePicker.delegate = self;
    
    // Do not allow editing
    imagePicker.allowsEditing = YES;
    
    // Show image picker
	[self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
	photoImage  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Patients" inManagedObjectContext:context];
    
    [request setEntity:entityDescription];
    
    NSPredicate *pred = [NSPredicate
                         predicateWithFormat:@"(id == %@)",
                         self.patient.pid];
    [request setPredicate:pred];
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    Patients *updatingPatient = nil;
    if([fetchedObjects count] > 0)
    {
        updatingPatient = [fetchedObjects objectAtIndex:0];
        updatingPatient.smallPhoto = UIImagePNGRepresentation(photoImage);
    }
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    appDelegate.isReloadPatients = YES;
    [appDelegate SetPatientsList];
    
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"PatientDetailView";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma Send Email

- (IBAction) SendMail
{
    [self showEmailModalView:self.patient.email];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) showEmailModalView:(NSString *)email{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    // very important step if you want feedbacks on what the user did with your email sheet
    
    [picker setSubject:@""];
    
    // Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@", email]];
	
	[picker setToRecipients:toRecipients];
	
	// Attach an image to the email
	// NSString *path = [[NSBundle mainBundle] pathForResource:@"triodor_logo" ofType:@"jpg"];
    // NSData *myData = [NSData dataWithContentsOfFile:path];
	// [picker addAttachmentData:myData mimeType:@"image/jpg" fileName:@"triodor_logo"];
	
	// Fill out the email body text
	NSString *emailBody = [NSString stringWithFormat:@"Hi %@ %@,", self.patient.firstName, self.patient.lastName];
	[picker setMessageBody:emailBody isHTML:NO];
    picker.navigationBar.barStyle = UIBarStyleBlack;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma -
#pragma Phone Call

- (IBAction) Call
{
    if(![self.patient.phone isEqualToString:@""])
    {
        // Create the sheet without buttons
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"Please, select a phone number to call "
                                delegate:self
                                cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                otherButtonTitles:nil];
        
        
        [sheet addButtonWithTitle:[NSString stringWithFormat:@"%@", [self FormatNumberForCountry:self.patient.phone]]];
        
        [sheet addButtonWithTitle:[NSString stringWithFormat:@"%@", [self FormatNumberForCountry:self.patient.phone]]];
        
        // Also add a cancel button
        [sheet addButtonWithTitle:@"Cancel"];
        // Set cancel button index to the one we just added so that we know which one it is in delegate call
        // NB - This also causes this button to be shown with a black background
        //sheet.cancelButtonIndex = sheet.numberOfButtons-1;
        sheet.destructiveButtonIndex = sheet.numberOfButtons-1;
        sheet.tag = 0;
        
        [sheet showInView:self.parentViewController.tabBarController.view];
    }
    else if(![self.patient.phone isEqualToString:@""])
    {
        [self CallPhone:self.patient.phone];
    }
    else if([self.patient.phone isEqualToString:@""])
    {
        [self CallPhone:self.patient.phone];
    }
    
}

- (void)CallPhone:(NSString *)phone
{
    NSString *phoneStr;
    phoneStr = [[NSString alloc] initWithFormat:@"tel:%@", phone];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

-(NSString*)FormatNumberForCountry:(NSString*)mobileNumber
{
    NSString *formatedMobileNumber= nil;
    if([mobileNumber length] < 3)
        return mobileNumber;
    
    NSString *countryCode = [mobileNumber  substringToIndex:3];
    if([countryCode isEqualToString:@"+90"])
    {
        if([mobileNumber length] == 13)
            formatedMobileNumber = [NSString stringWithFormat:@"%@ (%@) %@ %@ %@",
                                    [mobileNumber  substringToIndex:3],
                                    [[mobileNumber substringFromIndex:3] substringToIndex:3],
                                    [[mobileNumber substringFromIndex:6] substringToIndex:3],
                                    [[mobileNumber substringFromIndex:9] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:11] substringToIndex:2]];
        
        else
            formatedMobileNumber = mobileNumber;
    }
    else if([countryCode isEqualToString:@"009"])
    {
        if([mobileNumber length] == 14)
            formatedMobileNumber = [NSString stringWithFormat:@"+90 (%@) %@ %@ %@",
                                    [[mobileNumber substringFromIndex:4] substringToIndex:3],
                                    [[mobileNumber substringFromIndex:7] substringToIndex:3],
                                    [[mobileNumber substringFromIndex:10] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:12] substringToIndex:2]];
        else
            formatedMobileNumber = mobileNumber;
    }
    else if([countryCode isEqualToString:@"006"] || [countryCode isEqualToString:@"003"])
    {
        if([mobileNumber length] == 11)
        {
            formatedMobileNumber = [NSString stringWithFormat:@"+31 (%@) %@ %@ %@ %@",
                                    [[mobileNumber substringFromIndex:2] substringToIndex:1],
                                    [[mobileNumber substringFromIndex:3] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:5] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:7] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:9] substringToIndex:2]];
        }
        else if ([mobileNumber length] == 13)
        {
            formatedMobileNumber = [NSString stringWithFormat:@"+31 (%@) %@ %@ %@ %@",
                                    [[mobileNumber substringFromIndex:4] substringToIndex:1],
                                    [[mobileNumber substringFromIndex:5] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:7] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:9] substringToIndex:2],
                                    [[mobileNumber substringFromIndex:11] substringToIndex:2]];
        }
        else
            formatedMobileNumber = mobileNumber;
    }
    else if([countryCode isEqualToString:@"+31"])
    {
        if([mobileNumber length] == 12)
        {
            NSString *areaCode = [[mobileNumber substringFromIndex:3] substringToIndex:1];
            if([areaCode isEqualToString:@"6"])
            {
                formatedMobileNumber = [NSString stringWithFormat:@"%@ (%@) %@ %@ %@ %@",
                                        [mobileNumber  substringToIndex:3],
                                        [[mobileNumber substringFromIndex:3] substringToIndex:1],
                                        [[mobileNumber substringFromIndex:4] substringToIndex:2],
                                        [[mobileNumber substringFromIndex:6] substringToIndex:2],
                                        [[mobileNumber substringFromIndex:8] substringToIndex:2],
                                        [[mobileNumber substringFromIndex:10] substringToIndex:2]];
            }
            else
            {
                formatedMobileNumber = [NSString stringWithFormat:@"%@ (%@) %@ %@ %@",
                                        [mobileNumber  substringToIndex:3],
                                        [[mobileNumber substringFromIndex:3] substringToIndex:2],
                                        [[mobileNumber substringFromIndex:5] substringToIndex:3],
                                        [[mobileNumber substringFromIndex:8] substringToIndex:2],
                                        [[mobileNumber substringFromIndex:10] substringToIndex:2]];
            }
        }
        else
            formatedMobileNumber = mobileNumber;
    }
    else
        formatedMobileNumber = mobileNumber;
    
    return formatedMobileNumber;
}

-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
}

#pragma -
#pragma Send SMS Messages

- (IBAction) SendMessage:(id) sender
{
    if(![self.patient.phone isEqualToString:@""])
    {
        // Create the sheet without buttons
        UIActionSheet *sheet = [[UIActionSheet alloc]
                                initWithTitle:@"Please, select a phone number to send sms"
                                delegate:self
                                cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                otherButtonTitles:nil];
        
        [sheet addButtonWithTitle:[NSString stringWithFormat:@"%@", [self FormatNumberForCountry:self.patient.phone]]];
        
        [sheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[self FormatNumberForCountry:self.patient.phone]]];
        
        // Also add a cancel button
        [sheet addButtonWithTitle:@"Cancel"];
        // Set cancel button index to the one we just added so that we know which one it is in delegate call
        // NB - This also causes this button to be shown with a black background
        //sheet.cancelButtonIndex = sheet.numberOfButtons-1;
        sheet.destructiveButtonIndex = sheet.numberOfButtons - 1;
        sheet.tag = 1;
        
        [sheet showInView:self.parentViewController.tabBarController.view];
    }
    else if(![self.patient.phone isEqualToString:@""])
    {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"";
            controller.recipients =
            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[self FormatNumberForCountry:self.patient.phone]], nil];
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }
    else if([self.patient.phone isEqualToString:@""])
    {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"";
            controller.recipients =
            [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[self FormatNumberForCountry:self.patient.phone]], nil];
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alert;
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
            alert= [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
