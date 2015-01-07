//
//  sfpViewController.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "sfpSettingsViewController.h"
#import "sfpRatingViewController.h"
#import "sfpHelpViewController.h"
@class calculateBAC;
@class calculateTotalAlcohol;
@class compareBAC;

@interface sfpViewController : UIViewController {
    sfpRatingViewController *rvc;
    sfpSettingsViewController *svc;
    sfpHelpViewController *hvc;

}

// Custom class properties
@property (nonatomic) calculateBAC *bacCalculator;
@property (nonatomic) calculateTotalAlcohol *totalAlcoholCalculator;
@property (nonatomic) compareBAC *bacCompare;

@property (nonatomic) NSUserDefaults *defaults;

// Displays hangover rating
@property (weak, nonatomic) IBOutlet UIImageView *imageDisplay;

// Stars image to display
@property (nonatomic) UIImage *ratingImage;

// Time calculation properties
@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval currentTime;

// Create buttons
@property (weak, nonatomic) IBOutlet UIButton *drinkList;
@property (weak, nonatomic) IBOutlet UIButton *thirdDrink;
@property (weak, nonatomic) IBOutlet UIButton *secondaryDrink;
@property (weak, nonatomic) IBOutlet UIButton *mainDrink;
@property (weak, nonatomic) IBOutlet UIButton *stopStart;
@property (nonatomic) IBOutlet UIBarButtonItem *settings;


// Button titles
@property (nonatomic) NSString *mainDrinkButtonTitle;
@property (nonatomic) NSString *secondaryDrinkButtonTitle;
@property (nonatomic) NSString *thirdDrinkButtonTitle;

// Calculation properties
@property (nonatomic) int mainDrinkOunces;
@property (nonatomic) int mainDrinkPercent;
@property (nonatomic) int secondaryDrinkOunces;
@property (nonatomic) int secondaryDrinkPercent;
@property (nonatomic) int thirdDrinkOunces;
@property (nonatomic) int thirdDrinkPercent;
@property (nonatomic) int weight;
@property (nonatomic) float percentAlc;
@property (nonatomic) float ounces;
@property (nonatomic) float genderConstant;
@property (nonatomic) float totalAlcohol;
@property (nonatomic) float bac;
@property (nonatomic) NSString *weightString;

@end
