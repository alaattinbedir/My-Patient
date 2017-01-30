//
//  AddPatientViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/21/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GAITrackedViewController.h"

@class AppDelegate;

@interface AddPatientViewController : GAITrackedViewController<ZBarReaderDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource>{
    AppDelegate *appDelegate;
    BOOL keyboardIsShown;
    UIImage *photoImage;
    BOOL qrCodeScaaned;
}

@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UITextField *genderTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateofBirthTextField;
@property (strong, nonatomic) IBOutlet UITextField *admissiondateTextField;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextView *addressTextView;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)scanButtonTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;

@property (strong, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *admissionDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UITextField *complaintsTextField;
@property (strong, nonatomic) IBOutlet UILabel *complaintsLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;

@property (strong, nonatomic) IBOutlet UITextField *commentsTextField;
@property (strong, nonatomic) NSArray *genderArray;

@end
