//
//  AppDelegate.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "AppDelegate.h"
#import "Patients.h"
#import "Appointments.h"
#import "GAI.h"
#import "PasscodeViewController.h"


/** Google Analytics configuration constants **/
static NSString *const kGaPropertyId = @"UA-46035456-1";            // Placeholder property ID.
static NSString *const kTrackingPreferenceKey = @"allowTracking";
static BOOL const kGaDryRun = NO;
static int const kGaDispatchPeriod = 30;


@interface AppDelegate ()

- (void)initializeGoogleAnalytics;

@end


@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (void)DeleteTestData{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    NSFetchRequest *patientsRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patients"
                                              inManagedObjectContext:context];
    [patientsRequest setEntity:entity];
    NSArray *patientsArray = [context executeFetchRequest:patientsRequest error:&error];
    
    for (Patients *patient in patientsArray) {
        [context deleteObject:patient];
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
    NSFetchRequest *appointmentsRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *appointmentEntity = [NSEntityDescription entityForName:@"Appointments"
                                               inManagedObjectContext:context];
    [appointmentsRequest setEntity:appointmentEntity];
    NSArray *appointmentsArray = [context executeFetchRequest:appointmentsRequest error:&error];
    
    for (Appointments *appointment in appointmentsArray) {

        [context deleteObject:appointment];
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

// Create test data
- (void)CreateTestData {
    NSLog(@"Creating Test Data");
    NSMutableArray *names = [[NSMutableArray alloc] initWithObjects: @"Alaattin" , @"Sleepy", @"Sneezy",
                             @"Bashful", @"Happy", @"Doc", @"Grumpy", @"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur",
                             @"Blaattin" , @"Cleepy", @"Dneezy",
                             @"Eashful", @"Fappy", @"Goc", @"Grumpy", @"Hopey", @"Ihorin", @"Jorin", @"KNori", @"LOri", @"MBalin", @"NDwalin", @"OFili", @"Kili", @"Pin", @"Rloin", @"SBifur", @"TBofur", @"UBombur",
                             @"VAlaattin" , @"YSleepy", @"ZSneezy",
                             @"ABashful", @"BHappy", @"CDoc", @"DGrumpy", @"EDopey", @"FThorin", @"GDorin", @"HNori", @"IOri", @"JBalin", @"KDwalin", @"LFili", @"MKili", @"NOin", @"OGloin", @"PBifur", @"RBofur", @"SBombur",
                             @"TAlaattin" , @"USleepy", @"VSneezy",
                             @"YBashful", @"ZHappy", @"QDoc", @"WGrumpy", @"WDopey", @"QThorin", @"XDorin", @"XNori", @"COri", @"UBalin", @"SDwalin", @"AFili", @"WKili", @"QOin", @"HGloin", @"YBifur", @"SBofur", @"KBombur",
                             @"Alaattin" , @"Sleepy", @"Sneezy",
                             @"Bashful", @"Happy", @"Doc", @"Grumpy", @"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur",
                             @"Blaattin" , @"Cleepy", @"Dneezy",
                             @"Eashful", @"Fappy", @"Goc", @"Grumpy", @"Hopey", @"Ihorin", @"Jorin", @"KNori", @"LOri", @"MBalin", @"NDwalin", @"OFili", @"Kili", @"Pin", @"Rloin", @"SBifur", @"TBofur", @"UBombur",nil];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    

    NSMutableString *imagePath;
    imagePath=[[NSMutableString  alloc] initWithString: [[NSBundle mainBundle] resourcePath]];
    [imagePath appendString:@"/"] ;
    [imagePath appendString:@"alaattinbedir.jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    
    for (int i = 1; i < 21*6; i++) {
        Patients *patients = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Patients"
                              inManagedObjectContext:context];
        

        patients.firstName = [names objectAtIndex:i-1];
        patients.lastName = @"Bedir";
        patients.phone = @"05055362405";
        patients.emergencyNo = @"";
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        NSString* admissionDate = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-30*60*60*24*365]];

        patients.admissionDate = admissionDate;
        patients.dateOfBirth = admissionDate;
        patients.address = @"alaattinbedir";
        patients.email = @"alaattinbedir@yahoo.com";
        patients.comments = @"Durumu iyi";
        patients.complaints = @"Diyabet, Tansiyon";
        patients.smallPhoto = imageData;
        patients.gender = [NSNumber numberWithInt:2];
        patients.deleted = NO;
        patients.pid = [NSNumber numberWithInt:i];
        
        
//        if (i < 10)
//            for (int j = 1; j < 5 ; j++) {
//                Appointments *appointments = [NSEntityDescription
//                                              insertNewObjectForEntityForName:@"Appointments"
//                                              inManagedObjectContext:context];
//
//                patients.patients_appointments = appointments;
//                appointments.appointments_patients = patients;
//                
//                appointments.name = @"First appointment";
//
//                appointments.note = @"please come on time";
//                
//                NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
//                [dateFormatter2 setDateFormat:@"dd.MM.yyyy"];
//                NSString* appointmentDate = [dateFormatter2 stringFromDate:[NSDate dateWithTimeIntervalSinceNow:j*60*60*24]];
//                appointments.date = appointmentDate;
//                appointments.time = @"15:00";
//            }
        
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}


-(void) SetPatientsList{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSMutableDictionary *patientsListDictionary = [NSMutableDictionary dictionary];

    NSFetchRequest *patientsFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *patientsEntity = [NSEntityDescription entityForName:@"Patients"
                                               inManagedObjectContext:context];
    [patientsFetchRequest setEntity:patientsEntity];
    
    NSPredicate *pred = [NSPredicate
                         predicateWithFormat:@"(deleted = %@)",
                         [NSNumber numberWithBool:NO]];
    [patientsFetchRequest setPredicate:pred];

    
    patientsFetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    

    
    
    NSArray *fetchedPatients = [context executeFetchRequest:patientsFetchRequest error:&error];

//    // Set patient dictionary with patient.id key
    for (Patients *patient in fetchedPatients) {
        [patientsListDictionary setObject:patient forKey:patient.pid];
    }
    [Global sharedInstance].patientsDictionary = patientsListDictionary;
    
    // Sort list with alpahabetic order
    [[Global sharedInstance].patientsArray removeAllObjects];
    [Global sharedInstance].patientsArray = [NSMutableArray arrayWithArray:fetchedPatients];
    
}

-(void) SetAppointmentsList{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    //    NSMutableDictionary *patientsListDictionary = [NSMutableDictionary dictionary];
    
    NSFetchRequest *appointmentsFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *appointmentEntity = [NSEntityDescription entityForName:@"Appointments"
                                                      inManagedObjectContext:context];
    [appointmentsFetchRequest setEntity:appointmentEntity];
    appointmentsFetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSArray *fetchedAppointments = [context executeFetchRequest:appointmentsFetchRequest error:&error];
    
    // Sort list with alpahabetic order
    [[Global sharedInstance].appointmentsArray removeAllObjects];
    [Global sharedInstance].appointmentsArray = [NSMutableArray arrayWithArray:fetchedAppointments];
    
}

#pragma mark - DB Operations

- (NSString *) getDBPath {
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"MobilePatientTracker.sqlite"];
}

-(NSString *) getDBDefaultPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return documentsDir;
}

- (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [self getDBPath];
    NSLog(@"Db path : %@ ",dbPath);
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        [self DeleteTestData];
        [self CreateTestData];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDatabaseIfNeeded];
    [self SetPatientsList];
    [self SetAppointmentsList];
    
    // initialize Google Analytics.
    [self initializeGoogleAnalytics];
    
    self.isReloadAppointments = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL activated = [defaults boolForKey:@"passCode"];

    [self.window makeKeyAndVisible];
    
    if (activated) {
        UIStoryboard *iPhoneStoryboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
        PasscodeViewController *passcodeViewController = (PasscodeViewController*)[iPhoneStoryboard instantiateViewControllerWithIdentifier:@"Passcode"];
        passcodeViewController.delegate = self;
        
//        UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:passcodeViewController];
        
        [self.window.rootViewController presentViewController:passcodeViewController animated:NO completion:nil];
    }
    
    return YES;
}

- (void)initializeGoogleAnalytics {
    
    [[GAI sharedInstance] setDispatchInterval:kGaDispatchPeriod];
    [[GAI sharedInstance] setDryRun:kGaDryRun];
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
}

//-(void)loginViewControllerDidFinish:(LoginViewController *)loginViewController {
//    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
//}

-(void)passcodeViewControllerDidFinish:(PasscodeViewController *)passcodeViewController {
    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL activated = [defaults boolForKey:@"passCode"];
    
    if (activated) {
        UIStoryboard *iPhoneStoryboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
        PasscodeViewController *passcodeViewController = (PasscodeViewController*)[iPhoneStoryboard instantiateViewControllerWithIdentifier:@"Passcode"];
        passcodeViewController.delegate = self;
        
        [self.window.rootViewController presentViewController:passcodeViewController animated:NO completion:nil];
    }
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MobilePatientTracker" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MobilePatientTracker.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
