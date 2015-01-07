//
//  sfpTableViewController.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sfpTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *beerName;
@property (nonatomic) NSArray *beerNameKeys;
@property (nonatomic) NSString *percentSelected;
@property (nonatomic) NSString *sizeSelected;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *bbi;
@property (nonatomic) UIBarButtonItem *backButton;
@property (nonatomic) NSString *enteredSize;
@property (nonatomic) NSUserDefaults *defaults;
@property int tracker;

@property (nonatomic) NSString *mainDrinkTitle;
@property (nonatomic) NSString *secondaryDrinkTitle;
@property (nonatomic) NSString *thirdDrinkTitle;

@property (nonatomic) NSString *mainDrinkPercent;
@property (nonatomic) NSString *secondaryDrinkPercent;
@property (nonatomic) NSString *thirdDrinkPercent;

@property (nonatomic) NSString *mainDrinkSize;
@property (nonatomic) NSString *secondaryDrinkSize;
@property (nonatomic) NSString *thirdDrinkSize;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
