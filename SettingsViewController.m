//
//  SettingsViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize passCodeLabel;
@synthesize passCodeSwitch;

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

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL activated = [defaults boolForKey:@"passCode"];
    self.passCodeSwitch.on = activated;

}

-(void)viewWillAppear:(BOOL)animated{
    [self addLogutButton];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)passCodeChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL remember = passCodeSwitch.on;
    [defaults setBool:remember forKey:@"passCode"];
    
    [defaults synchronize];
    
    [self addLogutButton];
}
@end
