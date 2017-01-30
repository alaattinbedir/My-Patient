//
//  LoginViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/19/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;


@end


@implementation LoginViewController

@synthesize delegate,tableView;

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
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSNumber *buildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [self.versionLabel setText:[NSString stringWithFormat:@"%@ %@.%@", appName, shortVersion, buildNumber]];
    [self.versionLabel setTextColor:[UIColor redColor]];

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"LoginView";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) login :(NSString*) user withPassword: (NSString*) pwd withDomain: (NSString*) domain
{
    // May return nil if a tracker has not already been initialized with a property
    // ID.
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"login_action"  // Event action (required)
                                                           label:@"login"         // Event label
                                                           value:nil] build]];    // Event value
    
    NSString *url = [NSString stringWithFormat:@"http://teros.triodor.eu/authenticate.aspx?username=%@&password=%@&domain=%@",user ,pwd, domain];
    
    NSURL *reqUrl = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:reqUrl];
    NSError *error;
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSStringEncoding responseEncoding = NSUTF8StringEncoding;
    if ([response textEncodingName]) {
        CFStringEncoding cfStringEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)[response textEncodingName]);
        if (cfStringEncoding != kCFStringEncodingInvalidId) {
            responseEncoding = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding);
        }
    }
    
    NSString *dataString = [[NSString alloc] initWithData:data encoding:responseEncoding];
    NSLog(@"%@",dataString);
	BOOL authenticated = YES; //[dataString boolValue];
	
    if(authenticated){
        [self.delegate loginViewControllerDidFinish:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccesful" object:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:@"Login failed!"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
	return authenticated;
}

#pragma mark -
#pragma mark TextField Delagate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
	// Use login info to login
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Create strings and integer to store the text info
    NSString *loginName = nil;
    NSString *loginPassword  = nil;
    
    switch (textField.tag) {
        case 1:
			loginName = [textField text];
            [defaults setObject:loginName forKey:@"loginName"];
			break;
		case 2:
			loginPassword = [textField text];
            [defaults setObject:loginPassword forKey:@"loginPassword"];
			break;
		default:
			break;
	}
    
    [defaults synchronize];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:

        default:
            break;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	UITableViewCell *cell = (UITableViewCell *)[self.tableView superview];
	UITextField *nextField = nil;
	
	if (textField.tag == 1)
	{
		nextField = (UITextField *) [cell viewWithTag:2];
		[nextField becomeFirstResponder];
    }
    else if (textField.tag == 2)
	{
		[textField resignFirstResponder];
    }
    
    if(textField.returnKeyType == UIReturnKeyGo)
	{
        // Get the stored data before the view loads
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *loginName = [defaults objectForKey:@"loginName"];
        NSString *loginPassword = [defaults objectForKey:@"loginPassword"];
        
		[self login:loginName withPassword:loginPassword withDomain:@"tr"];
	}
	return YES;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    switch (row) {
        case 0:

        default:
            break;
    }
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UITextField *txtCell = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 270, 30)];
    txtCell.clearsOnBeginEditing = NO;
    [txtCell setDelegate:self];
    txtCell.borderStyle = UITextBorderStyleNone;
    txtCell.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtCell.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    int row = [indexPath row];
    switch (row) {
        case 0:
            txtCell.tag = 1;
            txtCell.placeholder = @"User Name";
            txtCell.text = @"Alaattin";
            txtCell.keyboardType = UIKeyboardTypeAlphabet;
            txtCell.returnKeyType = UIReturnKeyNext;
            txtCell.enablesReturnKeyAutomatically = NO;
            break;
        case 1:
            txtCell.tag = 2;
            txtCell.placeholder = @"Password";
            txtCell.text = @"ab1234";
            txtCell.keyboardType = UIKeyboardTypeAlphabet;
            txtCell.returnKeyType = UIReturnKeyGo;
            txtCell.secureTextEntry = YES;
            break;
        default:
            break;
    }
    
    [cell.contentView addSubview:txtCell];

    //}
    return cell;
}


@end
