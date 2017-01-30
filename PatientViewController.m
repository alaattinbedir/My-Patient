//
//  PatientViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "PatientViewController.h"
#import "Patients.h"

@interface PatientViewController (){
    PatientCell *activeCell;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PatientViewController

@synthesize tableView;
@synthesize filteredNames;
@synthesize filteredKeys;
@synthesize searchBar;
@synthesize names;
@synthesize keys;
@synthesize namesFiltered,enableSwipe;


#pragma mark -
#pragma mark ViewController Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)resetSearch {
    
    self.names = [[Global sharedInstance] sectionOfPatients:[[Global sharedInstance] patientsArray]];
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:[[self.names allKeys]
                                   sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IS_IOS7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if (self.enableSwipe) {
        [self.navigationItem setTitle:JALocalizedString(@"KEY69",nil)];
        self.navigationItem.rightBarButtonItem = nil;
    }else
    {
        [self addLogutButton];
        [self addPatientButton];
    }
    
    [self resetSearch];
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];

    [self.view setBackgroundColor:SCREEN_BACKGROUNDCOLOR];
    [self.tableView setBackgroundColor:SCREEN_BACKGROUNDCOLOR];
    self.tableView.separatorColor = SCREEN_BACKGROUNDCOLOR;

    
    // Initialize the filteredCandyArray with a capacity equal to the patient's capacity
    filteredNames = [NSMutableArray arrayWithCapacity:[[Global sharedInstance].patientsArray count]];
    appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.screenName = @"PatientView";
}


-(void)viewWillAppear:(BOOL)animated
{
    [self addLogutButton];
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    if (appDelegate.isReloadPatients) {
        [self resetSearch];
        [tableView reloadData];
        appDelegate.isReloadPatients = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y - self.searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientCell *cell = (PatientCell *)[_tableView cellForRowAtIndexPath:indexPath];
    [self clearPreviousCell:cell];
    
    // Perform segue to candy detail
    if (!self.enableSwipe) {
        [self performSegueWithIdentifier:@"patientDetailSegue" sender:_tableView];
    }else
        [self performSegueWithIdentifier:@"addAppointmentSegue" sender:_tableView];

}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"patientDetailSegue"] ) {
        PatientDetailViewController *patientDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:activeCell];
            NSUInteger section = [indexPath section];
            
            NSString *key = [self.filteredKeys objectAtIndex:section];
            NSArray *nameSection = [self.namesFiltered objectForKey:key];
 
            Patients *patient = [nameSection objectAtIndex:[indexPath row]];
            [patientDetailViewController setPatient:patient];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:activeCell];
            NSUInteger section = [indexPath section];

            NSString *key = [self.keys objectAtIndex:section];
            NSArray *nameSection = [self.names objectForKey:key];
            
            Patients *patient = [nameSection objectAtIndex:indexPath.row];
            [patientDetailViewController setPatient:patient];
        }
    }else if ([[segue identifier] isEqualToString:@"addAppointmentSegue"])
    {
        AddAppointmentViewController *addAppointmentViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:activeCell];
            NSUInteger section = [indexPath section];
            
            NSString *key = [self.filteredKeys objectAtIndex:section];
            NSArray *nameSection = [self.namesFiltered objectForKey:key];
            

            Patients *patient = [nameSection objectAtIndex:[indexPath row]];
            
            [addAppointmentViewController setPatient:patient];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:activeCell];
            NSUInteger section = [indexPath section];
            
            NSString *key = [self.keys objectAtIndex:section];
            NSArray *nameSection = [self.names objectForKey:key];
            
            Patients *patient = [nameSection objectAtIndex:[indexPath row]];
            
            [addAppointmentViewController setPatient:patient];
        }
    }
}


#pragma mark -
#pragma mark Table Data Source Methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSUInteger section = [indexPath section];
        NSUInteger row = [indexPath row];
        NSString *key = [self.keys objectAtIndex:section];
        NSArray *nameSection = [self.names objectForKey:key];
        Patients *patient = [nameSection objectAtIndex:row];
        // TODO: delete patient from sqlite database
        
        
//        TriodorContactsAppDelegate *appDelegate = (TriodorContactsAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSError *error;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Patients" inManagedObjectContext:context];
        
        [request setEntity:entityDescription];
        
        NSPredicate *pred = [NSPredicate
                             predicateWithFormat:@"(pid = %@)",
                             patient.pid];
        [request setPredicate:pred];
        
        NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
        
        Patients *updatingPatient = nil;
        if([fetchedObjects count] > 0)
        {
            updatingPatient = [fetchedObjects objectAtIndex:0];
            updatingPatient.deleted = YES;
        }
        
        
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

        [appDelegate SetPatientsList];
        
        [self resetSearch];
        
        [self.tableView reloadData]; // tell table to refresh now
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NODECELL_HEIGHT;
}

- (NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key;
    if (_tableView == self.searchDisplayController.searchResultsTableView)
	{
        key = [filteredKeys objectAtIndex:section];
    }
	else
	{
        key = [keys objectAtIndex:section];
    }
   	
    return key;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView {
    if (_tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [[[Global sharedInstance] keysOfPatients:filteredNames] count];
    }
	else
	{
        return [keys count];
    }
}

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section {
	
    if (_tableView == self.searchDisplayController.searchResultsTableView)
	{
        NSString *key = [[[Global sharedInstance] keysOfPatients:filteredNames]  objectAtIndex:section];
        NSMutableDictionary *dict = [[Global sharedInstance] sectionOfPatients:filteredNames];
        NSUInteger rowsInSection = [[dict objectForKey:key] count];

        return rowsInSection;
    }
	else
	{
        NSString *key = [keys  objectAtIndex:section];
        NSUInteger rowsInSection = [[names objectForKey:key] count];
        
        return rowsInSection;
    }
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCellIdentifier";

    PatientCell *cell = (PatientCell*)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PatientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        [cell.replayButton addTarget:self action:@selector(replayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.favoriteButton addTarget:self action:@selector(favoriteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //Enable swipe guestures to show second view below swiped area
        cell.enableSwipe = !self.enableSwipe;
        
        [cell setLeftInset:0];
    }
    

    //you should set clockImage in subclass rather then here. Because this isnt changing and make this code more easier to read.
    UIImage *clockImage = [UIImage imageNamed:@"time_icon.png"];
    cell.clockImageView.image = clockImage;
    clockImage = nil;
    

    
    cell.favoriteButton.favoriteImageView.image = [UIImage imageNamed:@"favorite.png"];
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    // Create a new patients object
    Patients *patient = nil;

    if (_tableView == self.searchDisplayController.searchResultsTableView)
	{
        NSString *key = [self.filteredKeys objectAtIndex:section];
        NSArray *nameSection = [self.namesFiltered objectForKey:key];
        patient = [nameSection objectAtIndex:indexPath.row];
    }
	else
	{
        NSString *key = [keys objectAtIndex:section];
        NSArray *nameSection = [names objectForKey:key];
        patient = [nameSection objectAtIndex:row];
    }
    
    NSString *patientName = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    
    cell.titleLabel.text = patientName;
    
    NSString *gender = [patient.gender intValue] == 1 ? JALocalizedString(@"KEY73", nil) : JALocalizedString(@"KEY74", nil);
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    
    NSDate *dateOfBirth = [df dateFromString:patient.dateOfBirth];

    //calculate the difference from date to till date
    NSDateComponents* agecalcul = [[NSCalendar currentCalendar]
                                   components:NSYearCalendarUnit
                                   fromDate:dateOfBirth
                                   toDate:[NSDate date]
                                   options:0];
    //show the age as integer
    NSInteger age = [agecalcul year];

    
    cell.roleLabel.text = [NSString stringWithFormat:@"%@, %i ",gender,age];
    
    cell.detailLabel.text = patient.complaints;

    if(patient.smallPhoto.length > 0)
        [cell.profileImage setImage:[UIImage imageWithData:patient.smallPhoto]];
    else
        [cell.profileImage setImage:[UIImage imageNamed:@"picturePlageHolder.png"]];
    
//    cell.profileImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.alpha = .7;
    

    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)_tableView {
    if (_tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [[Global sharedInstance] keysOfPatients:self.filteredNames];
    }else{
        // should return section from mutable array contact list
        return [[Global sharedInstance] keysOfPatients:[[Global sharedInstance] patientsArray]];
    }
}

#pragma mark -
#pragma mark Nodecell Button Methods

-(void)replayPost:(id)sender{
    // add delay
//    [self performSelector:@selector(slideOut) withObject:self afterDelay:0.5 ];
    [self performSegueWithIdentifier:@"patientDetailSegue" sender:sender];
}

-(void)replayButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //Get AllPostCell instance from sender's superview hierarchy
    PatientCell *cell = (PatientCell *)[PatientCell findInstanceOnTree:(id)button];
    [self replayPost:cell];
}

- (void)setFavorites:(id)sender
{
    [self performSegueWithIdentifier:@"addAppointmentSegue" sender:sender];
}

-(void)favoriteButtonClicked:(id)sender
{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:activeCell];
    [self setFavorites:sender];
}


#pragma mark NodeCellDelegate implementations
-(void)clearPreviousCell:(NodeCell *)newCell
{
    if(activeCell)
    {
        if(activeCell != newCell)
        {
            if(activeCell.selected)
                [activeCell selectOut];
            if(activeCell.state == NodeCellStateOpen)
                [activeCell slideOut];
            activeCell = nil;
        }
    }
    activeCell = (PatientCell *)newCell;
}

-(void)didNodeCellSlideIn:(NodeCell *)cell
{
    [self clearPreviousCell:cell];
}

-(void)didNodeCellSlideOut:(NodeCell *)cell
{
    activeCell = nil;
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredNames removeAllObjects];
    
    NSArray *tempArray = nil;
    
    if([scope isEqualToString:@"First Name"]){
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstName contains[c] %@",searchText];
        tempArray = [[Global sharedInstance].patientsArray filteredArrayUsingPredicate:predicate];
    }
    else if([scope isEqualToString:@"Last Name"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.lastName contains[c] %@",searchText];
        tempArray = [[Global sharedInstance].patientsArray filteredArrayUsingPredicate:scopePredicate];
    }else if([scope isEqualToString:@"Phone"]){
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.phone contains[c] %@",searchText];
        tempArray = [[Global sharedInstance].patientsArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    self.filteredNames = [NSMutableArray arrayWithArray:tempArray];
    self.namesFiltered = [[Global sharedInstance] sectionOfPatients:self.filteredNames];
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObjectsFromArray:[[self.namesFiltered allKeys]
                                   sortedArrayUsingSelector:@selector(compare:)]];
    self.filteredKeys = keyArray;
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [self.searchBar becomeFirstResponder];
}


@end
