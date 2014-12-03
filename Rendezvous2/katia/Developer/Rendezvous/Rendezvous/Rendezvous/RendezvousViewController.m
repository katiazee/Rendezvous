//
//  RendezvousViewController.m
//  Rendezvous
//
//  Created by Katerina Zorko on 5/30/14.
//  Copyright (c) 2014 KaterinaZorko. All rights reserved.
//

#import "SingletonClass.h"
#import "RendezvousViewController.h"

@interface RendezvousViewController ()

@end

@implementation RendezvousViewController
@synthesize distanceSelector;
@synthesize locationSelector;
@synthesize hourSelector;
@synthesize hourLabel;
@synthesize finishSettings;
//@synthesize minuteData;
/*@synthesize hour;
@synthesize minute;*/


- (void)viewDidLoad
{
    distanceSelector.hidden = YES;
    locationSelector.hidden = YES;
    
    if ([[SingletonClass getSomeData]  isEqual: @"location"])
         locationSelector.hidden = NO;
    else if ([[SingletonClass getSomeData]  isEqual: @"distance"])
         distanceSelector.hidden = NO;

    [super viewDidLoad];
    
    self.hourData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    self.minuteData = @[@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50",  @"55"];
    self.blankData = @[@""];
    
    self.hourSelector.dataSource = self;
    self.hourSelector.delegate = self;
    
    //sets the hour
    if ([SingletonClass getUIPickerViewSettings] != -1)
    {
        [self.hourSelector selectRow:[SingletonClass getUIPickerViewSettings] inComponent:0 animated:YES];
        
    }
    else
        [self.hourSelector selectRow:2 inComponent:0 animated:YES];
    
    //sets the minutes
    if ([SingletonClass getUIPickerViewMin] != -1)
    {
        [self.hourSelector selectRow:[SingletonClass getUIPickerViewMin] inComponent:2 animated:YES];
        
    }
    else
        [self.hourSelector selectRow:5 inComponent:2 animated:YES];

    //sets the hour label text
    hourLabel.text = [SingletonClass getUIPickerViewHourLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)distanceSelected:(id)sender {
    distanceSelector.hidden = NO;
    locationSelector.hidden = YES;
    [SingletonClass setSomeData:@"distance"];
}

- (IBAction)locationSelected:(id)sender {
    distanceSelector.hidden = YES;
    locationSelector.hidden = NO;
    [SingletonClass setSomeData:@"location"];

}

- (IBAction)finishedWithSettings:(id)sender {
    
     if (distanceSelector.hidden == YES && locationSelector.hidden == YES)
     {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location or distance not selected"
                                                        message:@"Please select whether you would like to share your location or just your distance."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    
     }
     else
         [self performSegueWithIdentifier:@"finishedWithSettingsSegue" sender:self];
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return self.hourData.count;
    else if (component ==2)
        return self.minuteData.count;
    else
        return 0;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [self.hourData objectAtIndex:row];
    }
    else if (component == 2)
    {
        return [self.minuteData objectAtIndex:row];
    }
    else
        return [self.blankData objectAtIndex:row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
        [SingletonClass setUIPickerViewSettings:row];
    else if (component == 2)
        [SingletonClass setUIPickerViewMin:row];

    if (component == 0 && row == 0)
    {
        hourLabel.text = @"hr";
        [SingletonClass setUIPickerViewHourLabel:hourLabel.text];
    }
    else if (component == 0 && row != 0)
    {
        hourLabel.text = @"hrs";
        [SingletonClass setUIPickerViewHourLabel:hourLabel.text];
    }
}
@end
