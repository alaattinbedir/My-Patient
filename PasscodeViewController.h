//
//  PasscodeViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 5/20/14.
//  Copyright (c) 2014 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PasscodeViewControllerDelegate;
@interface PasscodeViewController : UIViewController<UITextFieldDelegate>{
        id<PasscodeViewControllerDelegate> delegate;
    
    
}

@property(nonatomic,strong) id<PasscodeViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *passcodeOne;
@property (strong, nonatomic) IBOutlet UITextField *passcodeTwo;
@property (strong, nonatomic) IBOutlet UITextField *passcodeThree;
@property (strong, nonatomic) IBOutlet UITextField *passcodeFour;
@property (strong, nonatomic) IBOutlet UILabel *enterPasscodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *setPasscodeLabel;

@end

@protocol PasscodeViewControllerDelegate <NSObject>
-(void) passcodeViewControllerDidFinish:(PasscodeViewController *) passcodeViewController;
@end
