//
//  AppointmentsViewController.m
//  MobilePatientTracker
//
//  Created by Alaattin Bedir on 11/18/13.
//  Copyright (c) 2013 Alaattin Bedir. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "AppointmentCell.h"
#import "PatientViewController.h"

@interface AppointmentsViewController (){
    AppointmentCell *activeCell;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *sections;
@property (strong, nonatomic) NSArray *sortedDays;
@property (strong, nonatomic) NSDateFormatter *sectionDateFormatter;



@end

@implementation AppointmentsViewController

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
    
    
    if (IS_IOS7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    [self.view setBackgroundColor:SCREEN_BACKGROUNDCOLOR];
    [self.tableView setBackgroundColor:SCREEN_BACKGROUNDCOLOR];
    self.tableView.separatorColor = SCREEN_BACKGROUNDCOLOR;

    
    appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    
    [self.navigationItem setTitle:JALocalizedString(@"KEY70", nil)];
    [self addAppointmentButton];

    self.sections = [NSMutableDictionary dictionary];
    
    self.sectionDateFormatter = [[NSDateFormatter alloc] init];
    [self.sectionDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.sectionDateFormatter setTimeStyle:NSDateFormatterNoStyle];


    
}



- (void)setAppoinmentList {
    
    [self.sections removeAllObjects];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    
    for (Appointments *appointment in [Global sharedInstance].appointmentsArray)
    {
        // Reduce event start date to date components (year, month, day)
        NSDate *dateRepresentingThisDay = [df dateFromString:appointment.date];
        
        // If we don't yet have an array to hold the events for this day, create one
        NSMutableArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
        if (eventsOnThisDay == nil) {
            eventsOnThisDay = [NSMutableArray array];
            
            // Use the reduced date as dictionary key to later retrieve the event list this day
            [self.sections setObject:eventsOnThisDay forKey:dateRepresentingThisDay];
        }
        
        // Add the event to the list for this day
        [eventsOnThisDay addObject:appointment];
    }
    
    // Create a sorted list of days
    NSMutableArray *unsortedDays = [[self.sections allKeys] mutableCopy];
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending:NO];
    
    self.sortedDays = [unsortedDays sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortOrder]];;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self addLogutButton];

    if (appDelegate.isReloadAppointments) {
        [self setAppoinmentList];
        [self.tableView reloadData];
        appDelegate.isReloadAppointments = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"patientForAppointmetSegue"] ) {
        PatientViewController *patientViewController = [segue destinationViewController];
        patientViewController.enableSwipe = YES;
    }
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentCell *cell = (AppointmentCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self clearPreviousCell:cell];
    
    // Perform segue to candy detail
    [self performSegueWithIdentifier:@"patientDetailSegue" sender:tableView];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NODECELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    return [eventsOnThisDay count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    return [self.sectionDateFormatter stringFromDate:dateRepresentingThisDay];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCellIdentifier";
    
    
    AppointmentCell *cell = (AppointmentCell*)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
        //Enable swipe guestures to show second view below swiped area
        cell.enableSwipe = NO;
        
        [cell setLeftInset:0];
    }
    
    
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *eventsOnThisDay = [self.sections objectForKey:dateRepresentingThisDay];
    Appointments *appointment = [eventsOnThisDay objectAtIndex:indexPath.row];
    
    //you should set clockImage in subclass rather then here. Because this isnt changing and make this code more easier to read.
    UIImage *clockImage = [UIImage imageNamed:@"time_icon.png"];
    cell.clockImageView.image = clockImage;
    clockImage = nil;
    
    cell.timeLabel.text = appointment.time;
    cell.detailLabel.text = appointment.note;
    cell.profileImage.image = [UIImage imageWithData:((Patients*)[[Global sharedInstance].patientsDictionary objectForKey:appointment.patientId]).smallPhoto];
    //[UIImage imageNamed:@"alaattinbedir.jpg"];
    
    cell.favoriteButton.favoriteImageView.image = [UIImage imageNamed:@"favorite.png"];
    
    
    NSString *appointmentName = [NSString stringWithFormat:@"%@", appointment.name];
    
    cell.titleLabel.text = appointmentName;
    cell.roleLabel.text = @"Appointment";
    
    cell.imageView.alpha = .7;
    
    
    return cell;
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
    activeCell = (AppointmentCell *)newCell;
}

-(void)didNodeCellSlideIn:(NodeCell *)cell
{
    [self clearPreviousCell:cell];
}

-(void)didNodeCellSlideOut:(NodeCell *)cell
{
    activeCell = nil;
}

@end
