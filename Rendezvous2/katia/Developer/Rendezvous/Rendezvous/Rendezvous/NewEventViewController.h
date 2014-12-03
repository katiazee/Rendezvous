//
//  NewEventViewController.h
//  Rendezvous
//
//  Created by Katerina Zorko on 6/30/14.
//  Copyright (c) 2014 KaterinaZorko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//@class SPGooglePlacesAutocompleteQuery;

@interface NewEventViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>//, UISearchDisplayDelegate, UISearchBarDelegate, MKMapViewDelegate>
{
    __weak IBOutlet UITextView *description;
    __weak IBOutlet UIButton *selectFriends;
    //__weak IBOutlet UILabel *firstName;
    __weak IBOutlet UITextView *friendsList;
    __weak IBOutlet UILabel *dateAndTime;
    __weak IBOutlet UIScrollView *scrollview;
    __weak IBOutlet UITextView *eventName;
    
    __weak IBOutlet UIButton *selectMeetingLocation;
    CLLocationManager *locationManager;

   // IBOutlet MKMapView *mapView;
   // NSArray *searchResultPlaces;
    //SPGooglePlacesAutocompleteQuery *searchQuery;
    //MKPointAnnotation *selectedPlaceAnnotation;
    
    BOOL shouldBeginEditing;
}
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)backgroundTap:(id)sender;
//- (IBAction)recenterMapToUserLocation:(id)sender;
- (IBAction)done:(id)sender;

- (IBAction)selectFriends:(id)sender;

@end

