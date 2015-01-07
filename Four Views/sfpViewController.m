//
//  sfpViewController.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "sfpViewController.h"
#import "sfpTableViewController.h"
#import "beerStore.h"
#import "Beer.h"
#import "calculateBAC.h"
#import "calculateTotalAlcohol.h"
#import "compareBAC.h"

@interface sfpViewController ()

@end

@implementation sfpViewController

@synthesize bacCalculator, totalAlcoholCalculator, bacCompare;
@synthesize drinkList, thirdDrink, secondaryDrink, mainDrink, stopStart, settings, weightString;
@synthesize imageDisplay;
@synthesize elapsed, startTime, currentTime;
@synthesize ratingImage;
@synthesize defaults;
@synthesize mainDrinkOunces, mainDrinkPercent, secondaryDrinkOunces, secondaryDrinkPercent, thirdDrinkOunces, thirdDrinkPercent, weight, genderConstant, percentAlc, ounces, totalAlcohol, bac;

@synthesize mainDrinkButtonTitle, secondaryDrinkButtonTitle, thirdDrinkButtonTitle;

int resetCalc = 0; // Tells whether to reset calculator when calculator view loads
int stopStartInt = 0; // Used for stop & start functionality - determines button color and mode
int alertPercent = 0; // Used for checking if user's input for %alc is appropriate
int settingsToggle = 0; // If weight is blank, don't let user hit Start

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"appBackground"]];
    self.navigationItem.title = @"Zero Hangover";
    CGRect frame = self.view.frame;
    frame.origin.y = 0.0;
    self.view.frame = frame;

    defaults = [NSUserDefaults standardUserDefaults];
    
    bacCalculator = [[calculateBAC alloc] init];
    bacCompare = [[compareBAC alloc] init];
    totalAlcoholCalculator = [[calculateTotalAlcohol alloc] init];
    
    NSArray *buttons = [NSArray arrayWithObjects:drinkList, mainDrink, secondaryDrink, thirdDrink, nil];
    
    for (UIButton *button in buttons) {
        button.clipsToBounds = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"appBG.png"] forState:UIControlStateHighlighted];
    }
    
    // Add settings button to navigation bar
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Settings"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(settings:)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    // Add help button to navigation bar
    UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStyleBordered target:self action:@selector(help:)];
    self.navigationItem.rightBarButtonItem = helpButton;

    // Add custom buttons and define properties
    [stopStart setTitle:@"Start" forState:UIControlStateNormal];
    [stopStart setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
    stopStart.clipsToBounds = YES;
    [stopStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [stopStart addTarget:self action:@selector(stopStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [drinkList addTarget:self action:@selector(goToTableButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainDrink addTarget:self action:@selector(addMainDrink:) forControlEvents:UIControlEventTouchUpInside];
    [secondaryDrink addTarget:self action:@selector(addSecondaryDrink:) forControlEvents:UIControlEventTouchUpInside];
    [thirdDrink addTarget:self action:@selector(addThirdDrink:) forControlEvents:UIControlEventTouchUpInside];
    
    // If the beerStore is empty, then create three default drinks
    if ([[[beerStore sharedBeerStore] allBeers] count] == 0) {
        Beer *defaultOne = [[beerStore sharedBeerStore] createBeerWithName:@"Spotted Cow" andPercent:@"4.8" andSize:@"12"];
        Beer *defaultTwo = [[beerStore sharedBeerStore] createBeerWithName:@"Capt Morgan" andPercent:@"35" andSize:@"1.5"];
        Beer *defaultThree = [[beerStore sharedBeerStore] createBeerWithName:@"Long Island" andPercent:@"22" andSize:@"6"];
        [[beerStore sharedBeerStore] saveChanges];
        
        // Generate the drink titles to place on the main buttons
        NSString *mainDrinkTitle = [NSString stringWithFormat:@"%@ %@oz", [defaultOne beerName], [defaultOne beerSize]];
        NSString *secondaryDrinkTitle = [NSString stringWithFormat:@"%@ %@oz", [defaultTwo beerName], [defaultTwo beerSize]];
        NSString *thirdDrinkTitle= [NSString stringWithFormat:@"%@ %@oz", [defaultThree beerName], [defaultThree beerSize]];
        [defaults setObject:mainDrinkTitle forKey:@"mainDrinkKey"];
        [defaults setObject:secondaryDrinkTitle forKey:@"secondaryDrinkKey"];
        [defaults setObject:thirdDrinkTitle forKey:@"thirdDrinkKey"];
        [defaults setObject:[defaultOne beerPercentAlcohol] forKey:@"mainDrinkPercentKey"];
        [defaults setObject:[defaultOne beerSize] forKey:@"mainDrinkSizeKey"];
        [defaults setObject:[defaultTwo beerPercentAlcohol] forKey:@"secondaryDrinkPercentKey"];
        [defaults setObject:[defaultTwo beerSize] forKey:@"secondaryDrinkSizeKey"];
        [defaults setObject:[defaultThree beerPercentAlcohol] forKey:@"thirdDrinkPercentKey"];
        [defaults setObject:[defaultThree beerSize] forKey:@"thirdDrinkSizeKey"];
        [defaults synchronize];
        
        mainDrinkButtonTitle = [defaults objectForKey:@"mainDrinkKey"];
        secondaryDrinkButtonTitle = [defaults objectForKey:@"secondaryDrinkKey"];
        thirdDrinkButtonTitle = [defaults objectForKey:@"thirdDrinkKey"];
        [mainDrink setTitle:mainDrinkButtonTitle forState:UIControlStateNormal];
        [secondaryDrink setTitle:secondaryDrinkButtonTitle forState:UIControlStateNormal];
        [thirdDrink setTitle:thirdDrinkButtonTitle forState:UIControlStateNormal];
    }
    //else {}
    
    [defaults setFloat:0.25 forKey:@"totalBACKey1"];
    [defaults setFloat:0.2 forKey:@"totalBACKey2"];
    [defaults setFloat:0.15 forKey:@"totalBACKey3"];
    [defaults setFloat:0.1 forKey:@"totalBACKey4"];
    [defaults setFloat:0.05 forKey:@"totalBACKey5"];
    [defaults setInteger:1 forKey:@"indexKey1"];
    [defaults setInteger:1 forKey:@"indexKey2"];
    [defaults setInteger:1 forKey:@"indexKey3"];
    [defaults setInteger:1 forKey:@"indexKey4"];
    [defaults setInteger:1 forKey:@"indexKey5"];
    [defaults setFloat:0.25 forKey:@"averageBACKey1"];
    [defaults setFloat:0.2 forKey:@"averageBACKey2"];
    [defaults setFloat:0.15 forKey:@"averageBACKey3"];
    [defaults setFloat:0.1 forKey:@"averageBACKey4"];
    [defaults setFloat:0.05 forKey:@"averageBACKey5"];
    
    // Set default gender to male at first boot
    if ([defaults objectForKey:@"genderKey"] == nil) {
        [defaults setObject:@"0.68" forKey:@"genderKey"];
    }
    
}

- (void) viewWillAppear:(BOOL)animated {
    // resetCalc is set to 1 when the user saves and quits for the night
    // After entering the rating, the next time this view appears it will
    // reset the start/stop button and bac, ounces, totalAlcohol in addition
    // to clearing the image of the number of stars
    if (resetCalc == 1) {
        [stopStart setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
        [stopStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [stopStart setTitle:@"Start" forState:UIControlStateNormal];
        [imageDisplay setImage:NULL];
        [totalAlcoholCalculator resetPreviousAlc];
        
        bac = 0;
        ounces = 0;
        totalAlcohol = 0;
        resetCalc = 0;
    }
    else {
        // Set the labels for the buttons
        mainDrinkButtonTitle = [defaults objectForKey:@"mainDrinkKey"];
        secondaryDrinkButtonTitle = [defaults objectForKey:@"secondaryDrinkKey"];
        thirdDrinkButtonTitle = [defaults objectForKey:@"thirdDrinkKey"];
        [mainDrink setTitle:mainDrinkButtonTitle forState:UIControlStateNormal];
        [secondaryDrink setTitle:secondaryDrinkButtonTitle forState:UIControlStateNormal];
        [thirdDrink setTitle:thirdDrinkButtonTitle forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stopStartClicked:(id)sender {
    weightString = [defaults objectForKey:@"weightKey"];
    // if timer hasn't started, start timer and change button to stop button
    if (weightString.length == 0 && stopStartInt == 0) {
        settingsToggle = 1;
        UIAlertView *myAlert2 = [[UIAlertView alloc] initWithTitle:@"Configure Settings"
                                                          message:@"Before beginning, please configure your Settings."
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
        
                                                 otherButtonTitles: nil];
        [myAlert2 show];
    }
    else if (weightString.length != 0 && stopStartInt == 0) {
        [stopStart.layer removeAllAnimations];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [stopStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [stopStart setBackgroundImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];
        startTime = [NSDate timeIntervalSinceReferenceDate];
        
        stopStartInt = 1;
    }
    //if timer has started, throw alert asking if user wants to stop timer
    else if (stopStartInt == 1) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Stop The Timer"
                                                          message:@"Are you done for the night? This will save your data and then reset the calculator."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save & Go to Bed", nil];
        [myAlert show];
    }
}

- (IBAction)goToTableButton:(id)sender {
    // Load drinks table
    sfpTableViewController *tvc = [[sfpTableViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (IBAction)settings:(id)sender {
    // Load the settings view controller
    svc = [[sfpSettingsViewController alloc] initWithNibName:@"sfpSettingsViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:NO];
    //[self presentViewController:svc animated:YES completion:nil];
    
}

- (IBAction)help:(id)sender {
    // Load the help view controller
    hvc = [[sfpHelpViewController alloc] initWithNibName:@"sfpHelpViewController" bundle:nil];
    [self.navigationController pushViewController:hvc animated:NO];
}

- (IBAction)addMainDrink:(id)sender {
    if (stopStartInt == 1) {
        // Calculate new total elapsed time in hours
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        elapsed = (currentTime - startTime) / 3600;
        
        weight = [[defaults objectForKey:@"weightKey"] integerValue];
        genderConstant = [[defaults objectForKey:@"genderKey"] floatValue];
        percentAlc = [[defaults objectForKey:@"mainDrinkPercentKey"] floatValue];
        ounces = [[defaults objectForKey:@"mainDrinkSizeKey"] floatValue];
        
        totalAlcohol = [totalAlcoholCalculator withOunces:ounces withAlcPercent:percentAlc];
        bac = [bacCalculator bacCalculatorWithAlcohol: totalAlcohol withWeight:weight withGender:genderConstant withTime:elapsed];

         // Don't return negative values
         if (bac < 0) {
         bac = 0;
         }
         
         // Get and set the appropriate star image
         ratingImage = [bacCompare withCurrentBAC:bac];
         [imageDisplay setImage:ratingImage];
         
         // NSLog(@"bac: %f, time: %f ounces: %f, total alcohol: %f, stopStart: %i", bac, elapsed, ounces, totalAlcohol, stopStartInt);
    }
}

- (IBAction)addSecondaryDrink:(id)sender {
    if (stopStartInt == 1) {
        // Calculate new total elapsed time
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        elapsed = (currentTime - startTime) / 3600;
        weight = [[defaults objectForKey:@"weightKey"] integerValue];
        genderConstant = [[defaults objectForKey:@"genderKey"] floatValue];
        percentAlc = [[defaults objectForKey:@"secondaryDrinkPercentKey"] floatValue];
        ounces = [[defaults objectForKey:@"secondaryDrinkSizeKey"] floatValue];
        
        totalAlcohol = [totalAlcoholCalculator withOunces:ounces withAlcPercent:percentAlc];
        bac = [bacCalculator bacCalculatorWithAlcohol: totalAlcohol withWeight:weight withGender:genderConstant withTime:elapsed];
        
        // Don't return negative values
        if (bac < 0) {
            bac = 0;
        }
        
        // Get and set the appropriate star image
        ratingImage = [bacCompare withCurrentBAC:bac];
        [imageDisplay setImage:ratingImage];
        
        // NSLog(@"bac: %f, time: %f ounces: %f, total alcohol: %f, stopStart: %i", bac, elapsed, ounces, totalAlcohol, stopStartInt);
    }
}

- (IBAction)addThirdDrink:(id)sender {
    if (stopStartInt == 1) {
        // Calculate new total elapsed time
        currentTime = [NSDate timeIntervalSinceReferenceDate];
        elapsed = (currentTime - startTime) / 3600;
        
        weight = [[defaults objectForKey:@"weightKey"] integerValue];
        genderConstant = [[defaults objectForKey:@"genderKey"] floatValue];
        percentAlc = [[defaults objectForKey:@"thirdDrinkPercentKey"] floatValue];
        ounces = [[defaults objectForKey:@"thirdDrinkSizeKey"] floatValue];
        
        totalAlcohol = [totalAlcoholCalculator withOunces:ounces withAlcPercent:percentAlc];
        bac = [bacCalculator bacCalculatorWithAlcohol: totalAlcohol withWeight:weight withGender:genderConstant withTime:elapsed];
        
        // Don't return negative values
        if (bac < 0) {
            bac = 0;
        }
        
        // Get and set the appropriate star image
        ratingImage = [bacCompare withCurrentBAC:bac];
        [imageDisplay setImage:ratingImage];
        
        // NSLog(@"bac: %f, time: %f ounces: %f, total alcohol: %f, stopStart: %i", bac, elapsed, ounces, totalAlcohol, stopStartInt);
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // user has confirmed they want to stop timer via alert prompt -> load rating view
    if (buttonIndex == 1){
        
        // Get date to display on results page
        currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval _interval=currentTime;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        NSString *lastNightsDate = [formatter stringFromDate:date];
        
        [defaults setValue:lastNightsDate forKey:@"lastNightsDateKey"];
        
        // Save the current night's BAC
        [defaults setFloat:bac forKey:@"lastBAC"];
        [defaults synchronize];
        
        // Load the rating view controller
        rvc = [[sfpRatingViewController alloc] initWithNibName:@"sfpRatingViewController" bundle:nil];
        [self presentViewController:rvc animated:YES completion:NULL];
        
        resetCalc = 1; // Used in viewDidAppear.  Setting to 1 resets all the current night's data
        stopStartInt = 0; // Stop/start button reset
    }
    else if (settingsToggle == 1 && buttonIndex == 0) {
        settingsToggle = 0;
        svc = [[sfpSettingsViewController alloc] initWithNibName:@"sfpSettingsViewController" bundle:nil];
        [self.navigationController pushViewController:svc animated:YES];
    }
}


@end
