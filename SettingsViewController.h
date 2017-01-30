//
//  SettingsViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController{
    
}
@property (strong, nonatomic) IBOutlet UILabel *passCodeLabel;
@property (strong, nonatomic) IBOutlet UISwitch *passCodeSwitch;
- (IBAction)passCodeChanged:(id)sender;

@end
