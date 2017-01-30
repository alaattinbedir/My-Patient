//
//  LoginViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/19/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"


@protocol LoginViewControllerDelegate;

@interface LoginViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    id<LoginViewControllerDelegate> delegate;
}

@property(nonatomic,strong) id<LoginViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@protocol LoginViewControllerDelegate <NSObject>
-(void) loginViewControllerDidFinish:(LoginViewController *) loginViewController;
@end