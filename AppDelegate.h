//
//  AppDelegate.h
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasscodeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, PasscodeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) id<GAITracker> tracker;
@property (assign,nonatomic ) BOOL isReloadPatients;
@property (assign,nonatomic ) BOOL isReloadAppointments;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void) SetPatientsList;
-(void) SetAppointmentsList;

@end
