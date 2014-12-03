//
//  NewEventViewController.m
//  Rendezvous
//
//  Created by Katerina Zorko on 6/30/14.
//  Copyright (c) 2014 KaterinaZorko. All rights reserved.
//

#import "NewEventViewController.h"
#import "SPGooglePlacesAutocomplete.h"
#import "SPGooglePlacesAutocompleteDemoViewController.h"


//@import AddressBook;


@interface NewEventViewController ()

@end

@implementation NewEventViewController
{
   NSMutableArray* contacts;
   //NSMutableSet* contacts;

}
//@synthesize mapView;
//@synthesize scrollview;
BOOL eventTitleEntered = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    //searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:@"AIzaSyCHDvb-n6uw1eSUf5fq23XmG5HCHIU-1h4"];
    shouldBeginEditing = YES;
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //keeps text view description vertically justified
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.searchDisplayController.searchBar.placeholder = @"Enter meeting location...";
    
    description.clipsToBounds = YES;
    description.layer.cornerRadius = 10.0f;
    description.layer.borderWidth = 0.3f;
    description.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    eventName.clipsToBounds = YES;
    eventName.layer.cornerRadius = 10.0f;
    eventName.layer.borderWidth = 0.3f;
    eventName.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    selectFriends.clipsToBounds = YES;
    selectFriends.layer.cornerRadius = 10.0f;
    selectFriends.layer.borderWidth = 0.3f;
    selectFriends.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    friendsList.hidden = YES;
    friendsList.clipsToBounds = YES;
    friendsList.layer.cornerRadius = 10.0f;
    friendsList.layer.borderWidth = 0.3f;
    friendsList.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    dateAndTime.clipsToBounds = YES;
    dateAndTime.layer.cornerRadius = 10.0f;
    dateAndTime.layer.borderWidth = 0.3f;
    dateAndTime.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    selectMeetingLocation.clipsToBounds = YES;
    selectMeetingLocation.layer.cornerRadius = 10.0f;
    selectMeetingLocation.layer.borderWidth = 0.3f;
    selectMeetingLocation.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    
    contacts = [[NSMutableArray alloc] init];
    
//    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.contentSize = CGSizeMake(320,740);
    //scrollview.contentSize = CGSizeMake(320,960);
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:(id)self];
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];

    NSLog(@"The code runs through here! 1");
   // UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 //   [button addTarget:self  action:@selector(aMethod:) forControlEvents:UIControlEventTouchDown];
   // [button setTitle:@"Show View" forState:UIControlStateNormal];
    //button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    //[scrollview addSubview:button];
   // [scrollview addSubview:description];
   //UIScrollView *tempScrollView=(UIScrollView *)self.view;
    
   // tempScrollView.contentSize=CGSizeMake(1280, 960);//self.view.bounds.size.width, self.view.bounds.size.height * 2);
    

    /*UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    */
  //  description.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    self->scrollview  = nil;
    [super viewDidUnload];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        if (textView == description)
            textView.text = @"Enter Description...";
        if (textView == eventName)
        {
            eventTitleEntered = NO;
            textView.text = @"Enter Event Name...";
        }
        textView.textColor = [UIColor lightGrayColor];
        textView.tag = 0;
        
    }
    else if (textView == eventName)
        eventTitleEntered = YES;

}

- (IBAction)backgroundTap:(id)sender
{
     [self.view endEditing:YES];
}
/*
- (IBAction)recenterMapToUserLocation:(id)sender {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = self->mapView.userLocation.coordinate;
    
    [self->mapView setRegion:region animated:YES];
}*/


 - (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   // textView.text = text;
    //[textView resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    if ([friendsList.text  isEqual: @"" ] && eventTitleEntered == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No event title and no friends selected"
                                                        message:@"Please title your event and select the friends you would like to add to the event."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if ([friendsList.text  isEqual: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No friends selected"
                                                        message:@"Please select the friends you would like to add to the event."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (eventTitleEntered == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No event title"
                                                        message:@"Please title your event."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
   
    else
        [self performSegueWithIdentifier:@"doneWithNewEvent" sender:self];

   /* UIStoryboard *storyboard = self.storyboard;
    SPGooglePlacesAutocompleteDemoViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"SpecialViewController"];*/
    
   /* UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SPGooglePlacesAutocompleteDemoViewController *viewController = [[SPGooglePlacesAutocompleteDemoViewController alloc] init];
    window.rootViewController = viewController;
    [window makeKeyAndVisible];*/
    
   // [self presentViewController:svc animated:YES completion:nil];
    
}
/*- (IBAction)selectMeetingLocation:(id)sender
{
    - (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            self.mapView.showsUserLocation = YES;
        }
    }
    
}*/
- (IBAction)selectFriends:(id)sender {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        NSLog(@"Authorized");
    } else {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                //4
                NSLog(@"Just denied");
                return;
            }
            //5
            NSLog(@"Just authorized");
        });
    }
    
    
    
    ABPeoplePickerNavigationController *picker =
    
    [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (void)peoplePickerNavigationControllerDidCancel:

(ABPeoplePickerNavigationController *)peoplePicker

{
    //peoplePicker.peoplePickerDelegate = nil;
    [self dismissViewControllerAnimated:YES completion: nil];
    
}


- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    
    
    [self displayPerson:person];
   //peoplePicker.peoplePickerDelegate = nil;
    [self dismissViewControllerAnimated:YES completion: nil];
    
    return NO;
    
}

- (BOOL)peoplePickerNavigationController:

(ABPeoplePickerNavigationController *)peoplePicker

      shouldContinueAfterSelectingPerson:(ABRecordRef)person

                                property:(ABPropertyID)property

                              identifier:(ABMultiValueIdentifier)identifier

{
    
    return NO;
    
}

- (void)displayPerson:(ABRecordRef)person

{
    
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    //self->firstName.text = name;
    
    //checks if the user has already selected a certain name
    if (![contacts containsObject:name])
        [contacts addObject:name];
    
    //adds the selected person into a UITextView
    NSMutableString *string = [NSMutableString string];
    for( id object in contacts)
    {
        if (string.length == 0)
            [string appendString:[NSString stringWithFormat:@"%@", object]];
        else
            [string appendString:[NSString stringWithFormat:@", %@", object]];
    }
    friendsList.text = string;
    friendsList.hidden = NO;

    [friendsList resignFirstResponder];
    //TODO autorelease string!!
/*
    NSString* phone = nil;
    
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     
                                                     kABPersonPhoneProperty);
    
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        
        phone = (__bridge_transfer NSString*)
        
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        
    } else {
        
        phone = @"[None]";
        
    }
    
    self.phoneNumber.text = phone;
    
    CFRelease(phoneNumbers);*/
    
}
/*
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return searchResultPlaces[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self->mapView setRegion:region];
}

- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    [self->mapView removeAnnotation:selectedPlaceAnnotation];
    
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    selectedPlaceAnnotation.title = address;
    [self->mapView addAnnotation:selectedPlaceAnnotation];
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not map selected Place"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else if (placemark) {
            [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
            [self recenterMapToPlacemark:placemark];
            [self dismissSearchControllerWhileStayingActive];
            [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }];
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
   // NSLog(@"Hello %@");
    searchQuery.location = self->mapView.userLocation.coordinate;
    searchQuery.input = searchString;
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
         NSLog(@"Places returned %@", places);
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not fetch Places"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else {
            searchResultPlaces = places;
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
    NSArray *places;
        searchResultPlaces = places;
        [self.searchDisplayController.searchResultsTableView reloadData];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchDisplayController setActive:NO];
        [self->mapView removeAnnotation:selectedPlaceAnnotation];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 0.75;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

#pragma mark -
#pragma mark MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapViewIn viewForAnnotation:(id <MKAnnotation>)annotation {
    if (mapViewIn != self->mapView || [annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationIdentifier = @"SPGooglePlacesAutocompleteAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self->mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [detailButton addTarget:self action:@selector(annotationDetailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = detailButton;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    // Whenever we've dropped a pin on the map, immediately select it to present its callout bubble.
    [self->mapView selectAnnotation:selectedPlaceAnnotation animated:YES];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
