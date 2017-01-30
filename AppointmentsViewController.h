//
//  AppointmentsViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Appointments.h"
#import "AppDelegate.h"
#import "NodeCell.h"

@interface AppointmentsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,NodeCellDelegate>{
        AppDelegate *appDelegate;
}

@end
