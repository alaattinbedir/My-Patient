//
//  PatientViewController.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PatientDetailViewController.h"
#import "PatientCell.h"
#import "AddAppointmentViewController.h"

@interface PatientViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,NodeCellDelegate>{
    AppDelegate *appDelegate;
}

@property (strong,nonatomic) NSMutableArray *filteredNames;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableDictionary *namesFiltered;
@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableArray *filteredKeys;
@property (assign,nonatomic ) BOOL enableSwipe;


@end
