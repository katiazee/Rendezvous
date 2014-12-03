//
//  RendezvousViewController.h
//  Rendezvous
//
//  Created by Katerina Zorko on 5/30/14.
//  Copyright (c) 2014 KaterinaZorko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RendezvousViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>
{
  //  NSMutableDictionary *hours, *minutes;
   // NSArray *hour, *minute;    
}
@property (strong, nonatomic) IBOutlet UIImageView *distanceSelector;
@property (strong, nonatomic) IBOutlet UIImageView *locationSelector;
@property (strong, nonatomic) IBOutlet UIPickerView *hourSelector;
@property (nonatomic, retain) NSArray *hourData;
@property (nonatomic, retain) NSArray *minuteData;
@property (nonatomic, retain) NSArray *blankData;
@property (strong, nonatomic) IBOutlet UILabel *minuteLabel;
@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
@property (strong, nonatomic) IBOutlet UIButton *finishSettings;

- (IBAction)distanceSelected:(id)sender;
- (IBAction)locationSelected:(id)sender;
- (IBAction)finishedWithSettings:(id)sender;


@end
