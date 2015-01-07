//
//  sfpRatingViewController.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "sfpRatingViewController.h"
#import "sfpViewController.h"
#import "ratingStorage.h"
#import "verifyBounds.h"

@interface sfpRatingViewController ()

@end


@implementation sfpRatingViewController
@synthesize dateDisplay;
@synthesize newBAC;
@synthesize storeRating, verifyAverageOrder;
@synthesize oneStar, twoStars, threeStars, fourStars, fiveStars, deleteAll, deleteNight;

int rating = 0; // prevent user from selecting more than one rating
int clearToggle = 0; // toggle for clear all or delete night

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float loadBac = [defaults floatForKey:@"lastBAC"];
    NSString *lastNightsDate = [defaults valueForKey:@"lastNightsDateKey"];
    newBAC = loadBac;
    NSString *bacMessage = [[NSString alloc] initWithFormat:@"Rating for date: %@", lastNightsDate];
    storeRating = [[ratingStorage alloc] init];
    verifyAverageOrder = [[verifyBounds alloc] init];
    
    NSArray *buttons = [NSArray arrayWithObjects:oneStar, twoStars, threeStars, fourStars, fiveStars, deleteAll, deleteNight, nil];
    for (UIButton *button in buttons) {
        button.clipsToBounds = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"appBG.png"] forState:UIControlStateHighlighted];
    }
    
    deleteAll.clipsToBounds = YES;
    [deleteAll setBackgroundImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];
    
    [oneStar addTarget:self action:@selector(oneStarButton:) forControlEvents:UIControlEventTouchUpInside];
    [twoStars addTarget:self action:@selector(twoStarButton:) forControlEvents:UIControlEventTouchUpInside];
    [threeStars addTarget:self action:@selector(threeStarButton:) forControlEvents:UIControlEventTouchUpInside];
    [fourStars addTarget:self action:@selector(fourStarButton:) forControlEvents:UIControlEventTouchUpInside];
    [fiveStars addTarget:self action:@selector(fiveStarButton:) forControlEvents:UIControlEventTouchUpInside];
    [deleteNight addTarget:self action:@selector(deleteLastNight:) forControlEvents:UIControlEventTouchUpInside];
    [deleteAll addTarget:self action:@selector(clearAllSaved:) forControlEvents:UIControlEventTouchUpInside];
    
    [dateDisplay setText:bacMessage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)oneStarButton:(id)sender {
    if (rating == 0) {
        rating = 1;
        
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"One Star"
                                                          message:@"Are you sure you're this misearble?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Yes. Save.", nil];
        [myAlert show];
    }
}

- (IBAction)twoStarButton:(id)sender {
    if (rating == 0) {
        rating = 2;
        
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Two Stars"
                                                          message:@"Feeling pretty rough?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save", nil];
        [myAlert show];
    }
}

- (IBAction)threeStarButton:(id)sender {
    if (rating == 0) {
        rating = 3;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Three Stars"
                                                          message:@"Good enough for work?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save", nil];
        [myAlert show];
    }
}

- (IBAction)fourStarButton:(id)sender {
    if (rating == 0) {
        rating = 4;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Four Stars"
                                                          message:@"Just some ibuprofen?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save", nil];
        [myAlert show];
    }
}

- (IBAction)fiveStarButton:(id)sender {
    if (rating == 0) {
        rating = 5;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Five Stars"
                                                          message:@"No hangover?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save", nil];
        [myAlert show];
    }
}

- (IBAction)deleteLastNight:(id)sender {
    if (rating == 0) {
        clearToggle = 1;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Cancel"
                                                          message:@"Warning: This will delete last night's stats."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Delete", nil];
        [myAlert show];
    }
}

- (IBAction)clearAllSaved:(id)sender {
    if (rating == 0) {
        clearToggle = 2;
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Reset"
                                                          message:@"Warning: This will reset all saved data."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Reset", nil];
        [myAlert show];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (rating == 1 && buttonIndex == 1){
        //NSLog(@"New BAC: %f, rating: %i", newBAC, rating);
        
        [storeRating withBAC:newBAC withRating:rating];
        [verifyAverageOrder checkAverages]; // make sure no averages overtook their surrounding values
        
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (rating == 2 && buttonIndex == 1){
        // save bac data
        [storeRating withBAC:newBAC withRating:rating];
        [verifyAverageOrder checkAverages];
        
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (rating == 3 && buttonIndex == 1){
        // save bac data
        [storeRating withBAC:newBAC withRating:rating];
        [verifyAverageOrder checkAverages];
        
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (rating == 4 && buttonIndex == 1){
        // save bac data
        [storeRating withBAC:newBAC withRating:rating];
        [verifyAverageOrder checkAverages];
        
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (rating == 5 && buttonIndex == 1){
        // save bac data
        [storeRating withBAC:newBAC withRating:rating];
        [verifyAverageOrder checkAverages];
        
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
    
    else if (clearToggle == 1 && buttonIndex == 1) {
        rating = 0;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:0 forKey:@"lastBAC"];
        //NSLog(@"avgBAC1: %f, avgBAC2: %f, avgBAC3: %f,avgBAC4: %f, avgBAC5: %f", [defaults floatForKey:@"averageBACKey1"], [defaults floatForKey:@"averageBACKey2"], [defaults floatForKey:@"averageBACKey3"], [defaults floatForKey:@"averageBACKey4"], [defaults floatForKey:@"averageBACKey5"]);
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (clearToggle == 2 && buttonIndex == 1) {
        // clear all saved data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
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
        [defaults setFloat:0 forKey:@"lastBAC"];
        rating = 0;
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    else if (buttonIndex == 0) {
        rating = 0;
    }
}

@end
