
//
//  sfpSettingsViewController.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "sfpSettingsViewController.h"
#import "sfpViewController.h"

@interface sfpSettingsViewController ()

@end

@implementation sfpSettingsViewController
@synthesize genderConstant, weight, weightTextField, genderSegment;
@synthesize defaults;
@synthesize gender;
int alertWeight = 0; // Used for checking if user's input for weight is appropriate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    weightTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.navigationItem.title = @"Settings";
    // Add save button to navigation bar
    UIBarButtonItem *save = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Save"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = save;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    NSString *loadWeight = [defaults objectForKey:@"weightKey"];
    [weightTextField setText:loadWeight];
    
    gender = [defaults objectForKey:@"genderKey"];
    //NSLog(@"%f", [gender doubleValue]);
    if ([gender doubleValue] != 0.55) {
        genderSegment.selectedSegmentIndex = 0;
    }
    else {
        genderSegment.selectedSegmentIndex = 1;
    }
}

- (IBAction)genderSelector:(id)sender {
    UISegmentedControl *genderSelect = (UISegmentedControl *) sender;
    NSInteger selectedSegment = [genderSelect selectedSegmentIndex];
    if (selectedSegment == 0) {
        [defaults setObject:@"0.68" forKey:@"genderKey"];
        [defaults synchronize];
    }
    else {
        [defaults setObject:@"0.55" forKey:@"genderKey"];
        [defaults synchronize];
    }
}

- (IBAction)backToMain:(id)sender {
    // Load the main view controller
    NSString *weightText = weightTextField.text;
    if ([weightText integerValue] > 9999) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a weight of less than 10,000 lbs." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertWeight = 1;
        [myAlert show];
    }
    else if ([[weightTextField text] length] == 0) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a weight." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertWeight = 2;
        [myAlert show];
    }
    else {
        [defaults setObject:weightText forKey:@"weightKey"];
        [defaults synchronize];
        //NSLog(@"%@", [defaults objectForKey:@"weightKey"]);
        //NSLog(@"%@", [defaults objectForKey:@"genderKey"]);
        [self.navigationController popToRootViewControllerAnimated:NO
         ];
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    NSString *weightText = weightTextField.text;
    if ([weightText integerValue] > 9999) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a weight of less than 10,000 lbs." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertWeight = 1;
        [myAlert show];
    }
    else if ([[weightTextField text] length] == 0) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a weight." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertWeight = 2;
        [myAlert show];
    }
    else {
        [defaults setObject:weightText forKey:@"weightKey"];
        [defaults synchronize];
        [weightTextField resignFirstResponder];
        //NSLog(@"%@", [defaults objectForKey:@"weightKey"]);
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertWeight != 0) {
        alertWeight = 0;
    }
    else {
        
    }
}
@end
