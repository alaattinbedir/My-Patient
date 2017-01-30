
//
//  AddPatientViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/21/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "AddPatientViewController.h"

//#define kOFFSET_FOR_KEYBOARD 100.0
static int kOFFSET_FOR_KEYBOARD = 80;

@implementation AddPatientViewController

@synthesize scanButton, scrollView, photoImageView;
@synthesize genderArray;

#pragma mark -
#pragma mark Hide/Show keyboard for TextField

-(void)keyboardWillShow {
    
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
    

}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }

}



//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp withHeight:(CGFloat )height
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= height;
        rect.size.height += height;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += height;
        rect.size.height -= height;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addPatientButton
{
    UIBarButtonItem *savePatientButton = [[UIBarButtonItem alloc] initWithTitle:JALocalizedString(@"KEY71", nil) style:UIBarButtonItemStylePlain target:self action:@selector(savePatient:)];
    self.navigationItem.rightBarButtonItem = savePatientButton;
}

- (void)clear {
    self.firstNameTextField.text = @"";
    self.lastNameTextField.text = @"";
    self.genderTextField.text = @"";
    self.dateofBirthTextField.text = @"";
    self.admissiondateTextField.text = @"";
    self.addressTextView.text = @"";
    self.emailTextField.text = @"";
    self.phoneTextField.text = @"";
    self.photoImageView.image = [UIImage imageNamed:@"picturePlageHolder.png"];
}

- (void)savePatient:(id) sender{

    if ([self.firstNameTextField.text isEqualToString:@""] &&
        [self.lastNameTextField.text isEqualToString:@""] &&
        [self.genderTextField.text isEqualToString:@""]) {
        
        [[Global sharedInstance] showErrorMessageWithText:JALocalizedString(@"KEY75",nil)];
        return;
    }
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    Patients *patients = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Patients"
                          inManagedObjectContext:context];
    
    patients.firstName = self.firstNameTextField.text;
    patients.lastName = self.lastNameTextField.text;
    patients.phone = self.phoneTextField.text;
    patients.dateOfBirth = self.dateofBirthTextField.text;
    patients.address = self.addressTextView.text;
    patients.email = self.emailTextField.text;
    patients.comments = self.commentsTextField.text;
    patients.complaints = self.complaintsTextField.text;
    patients.smallPhoto = UIImagePNGRepresentation(photoImage);
    if ([self.genderTextField.text isEqualToString:JALocalizedString(@"KEY73", nil)]) {
        patients.gender = [NSNumber numberWithInt:1];
    }
    else{
        patients.gender = [NSNumber numberWithInt:2];
    }
    

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [[Global sharedInstance] showInfoMessageWithText:JALocalizedString(@"KEY67",nil)];

    [self hideKeyboard];
    [self clear];
    
    appDelegate.isReloadPatients = YES;
    [appDelegate SetPatientsList];
}

-(void)updateBirthtDate:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateofBirthTextField.inputView;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    
    // Reduce event start date to date components (year, month, day)
    NSString *appointmentDate = [df stringFromDate:picker.date];
    self.dateofBirthTextField.text = appointmentDate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIPickerView *genderPicker = [[UIPickerView alloc] init];
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    
    
    self.genderTextField.inputView = genderPicker;
    self.genderArray = [[NSArray alloc] initWithObjects:JALocalizedString(@"KEY73", nil), JALocalizedString(@"KEY74", nil), nil];
    
    UIDatePicker *patientBirthDatePicker = [[UIDatePicker alloc]init];
    [patientBirthDatePicker setDatePickerMode:UIDatePickerModeDate];
    [patientBirthDatePicker setDate:[NSDate date]];
    [patientBirthDatePicker addTarget:self action:@selector(updateBirthtDate:) forControlEvents:UIControlEventValueChanged];
    [self.dateofBirthTextField setInputView:patientBirthDatePicker];

    keyboardIsShown = NO;
    
    [self.scrollView setBackgroundColor:[UIColor colorWithR:248 G:248 B:248 A:1]];  
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, 490)];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addPatientButton];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
    [self.photoImageView.layer setCornerRadius:10.0f];
    [self.photoImageView.layer setMasksToBounds:YES];
    [self.photoImageView.layer setBorderWidth:1.0f];
    [self.photoImageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.photoImageView.userInteractionEnabled = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoImageView.image = [UIImage imageNamed:@"picturePlageHolder.png"];
    
    UITapGestureRecognizer *photoTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [photoTapGesture setNumberOfTapsRequired:1];
    [self.photoImageView addGestureRecognizer:photoTapGesture];

}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.genderArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.genderArray[row];
}


#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSString *gender = self.genderArray[row];
    
    
    self.genderTextField.text = gender;
}



- (void )imageTapped:(UIGestureRecognizer*)gesturerecogniser
{
    qrCodeScaaned = NO;
    
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
    if(qrCodeScaaned)
    {
        // ADD: get the decode results
        id<NSFastEnumeration> results =
        [info objectForKey: ZBarReaderControllerResults];
        ZBarSymbol *symbol = nil;
        for(symbol in results)
            // EXAMPLE: just grab the first barcode
            break;
        
        // EXAMPLE: do something useful with the barcode data
        self.addressTextView.text = symbol.data;
        
        // EXAMPLE: do something useful with the barcode image
        self.photoImageView.image =
        [info objectForKey: UIImagePickerControllerOriginalImage];
        
        // ADD: dismiss the controller (NB dismiss from the *reader*!)
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
	photoImage  = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.photoImageView.image = photoImage;
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"AddPatientView";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textfield{
    if(textfield == self.firstNameTextField){
        [self.lastNameTextField becomeFirstResponder];
    }else if(textfield == self.lastNameTextField){
        [self.genderTextField becomeFirstResponder];
    }else if(textfield == self.genderTextField){
        [self.dateofBirthTextField becomeFirstResponder];
    }else if(textfield == self.dateofBirthTextField){
        [self.emailTextField becomeFirstResponder];
    }else if(textfield == self.emailTextField){
        [self.phoneTextField becomeFirstResponder];
    }else if(textfield == self.phoneTextField){
        [self.phoneTextField becomeFirstResponder];
    }
    if(textfield.returnKeyType == UIReturnKeyGo)
	{
        [self.firstNameTextField becomeFirstResponder];
        [self savePatient:textfield];
    }
    return YES;
}


- (IBAction)scanButtonTapped:(id)sender {
    qrCodeScaaned = YES;
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];

}




@end
