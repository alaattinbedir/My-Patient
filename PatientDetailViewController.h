//
//  PatientDetailViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/26/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patients.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "GAITrackedViewController.h"
#import "AppDelegate.h"

@interface PatientDetailViewController : GAITrackedViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImage *photoImage;
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) Patients *patient;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *patientName;
@property (strong, nonatomic) IBOutlet UILabel *patientGender;
@property (strong, nonatomic) IBOutlet UILabel *admissiondateLabel;
@property (strong, nonatomic) IBOutlet UILabel *admissionDate;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UITextView *comments;
@property (strong, nonatomic) IBOutlet UILabel *complaintsLabel;
@property (strong, nonatomic) IBOutlet UITextView *complaints;
@property (strong, nonatomic) IBOutlet UILabel *emergencyNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *emergencyNo;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *smsButton;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UILabel *birthdate;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction) SendMessage:(id) sender;
- (IBAction) SendMail;
- (IBAction) Call;
- (void) showEmailModalView:(NSString *) email;
- (void) CallPhone:(NSString *) phone;
- (NSString*)FormatNumberForCountry:(NSString*)mobileNumber;

@end
