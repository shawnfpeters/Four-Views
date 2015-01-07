//
//  sfpTableViewController.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "sfpTableViewController.h"
#import "Beer.h"
#import "beerStore.h"

@interface sfpTableViewController ()

@end

@implementation sfpTableViewController
@synthesize beerName, beerNameKeys, percentSelected, tracker, doneButton, bbi, backButton, enteredSize, defaults, sizeSelected;
@synthesize mainDrinkTitle, secondaryDrinkTitle, thirdDrinkTitle;
@synthesize mainDrinkPercent, mainDrinkSize, secondaryDrinkPercent, secondaryDrinkSize, thirdDrinkPercent, thirdDrinkSize;

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Drink Select"];
        defaults = [NSUserDefaults standardUserDefaults];
        // Create a new bar button item that will send throwAlert: to the view controller
        bbi = [[UIBarButtonItem alloc] initWithTitle:@"Options" style:UIBarButtonItemStylePlain target:self action:@selector(throwAlert:)];
        backButton = [[UIBarButtonItem alloc] initWithTitle:@"< Back" style:UIBarButtonItemStylePlain target:self action:@selector(popBackToMain:)];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneEditing:)];
        [[self navigationItem] setLeftBarButtonItem:backButton];
        [[self navigationItem] setRightBarButtonItem:bbi];
        tracker = 0;
    }
    return self;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // Cancel
    if (buttonIndex == 0) {
        //NSLog(@"Cancel");
        tracker = 0;
    }
    //Edit
    else if (tracker == 0 && buttonIndex == 1) {
        [self.tableView setEditing:YES animated:YES];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        
    }
    // Add
    else if (tracker == 0 && buttonIndex == 2) {
        //NSLog(@"Add");
        //NSLog(@"%i", tracker);
        tracker = 4;
        UIAlertView *beerSize = [[UIAlertView alloc] initWithTitle:@"New Drink" message:@"Drink size (oz)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [beerSize setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[beerSize textFieldAtIndex:0] setPlaceholder:@"Size (oz)"];
        [[beerSize textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDecimalPad];
        [beerSize show];
    }
    // Size has been entered and OK hit
    else if (tracker == 4 && buttonIndex == 1) {
        //NSLog(@"%i", tracker);
        enteredSize = [[alertView textFieldAtIndex:0] text];
        //NSLog(@"%@", enteredSize);
        [defaults setObject:enteredSize forKey:@"sizeKey"];
        tracker = 1;
    }
    // Show prompt for drink name and percent
    if (tracker == 1 && buttonIndex == 1) {
        tracker = 2;
        UIAlertView *beerEntry = [[UIAlertView alloc] initWithTitle:@"New Drink" message:@"Enter a New Drink" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [beerEntry setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [beerEntry textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeWords;
        [[beerEntry textFieldAtIndex:1] setSecureTextEntry:NO];
        [[beerEntry textFieldAtIndex:0] setPlaceholder:@"Drink Name"];
        [[beerEntry textFieldAtIndex:1] setPlaceholder:@"%Alcohol"];
        [[beerEntry textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDecimalPad];
        [beerEntry show];
    }
    else if (tracker == 2 && buttonIndex == 1) {
        //NSLog(@"%i", tracker);
        NSString *enteredName = [[alertView textFieldAtIndex:0] text];
        NSString *enteredPercent = [[alertView textFieldAtIndex:1] text];
        NSString *size = [defaults objectForKey:@"sizeKey"];
        Beer *newBeer = [[beerStore sharedBeerStore] createBeerWithName:enteredName andPercent:enteredPercent andSize:size];
        [[beerStore sharedBeerStore] saveChanges];
        
        // Find out where to put the beer in the array
        NSUInteger lastRow = [[[beerStore sharedBeerStore] allBeers] indexOfObject:newBeer];
        
        // Make a new index path for the 0th section, last row
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        // Insert new row into table
        [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationBottom];
        
        tracker = 0;
    }
}

-(id) doneEditing:(id)sender {
    [self.tableView setEditing:NO animated:YES];
    [[self navigationItem] setRightBarButtonItem:bbi];
    return self;
}

- (void) popBackToMain: (id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void) throwAlert:(id)sender {
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Manage Drinks"
                                                      message:@"Add a Drink or Edit the List"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Edit", @"Add", nil];
    [myAlert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [[[beerStore sharedBeerStore] allBeers] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        
        Beer *b = [[[beerStore sharedBeerStore] allBeers] objectAtIndex:[indexPath row]];
        NSString *drinkTitle = [NSString stringWithFormat:@"%@ %@oz", [b beerName], [b beerSize]];
        [[cell textLabel] setText:drinkTitle];
        [[cell detailTextLabel] setText:[b beerPercentAlcohol]];
        return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete && ([[[beerStore sharedBeerStore] allBeers] count] - 1) != 0) {
        beerStore *bs = [beerStore sharedBeerStore];
        NSArray *beers = [bs allBeers];
        Beer *b = [beers objectAtIndex:[indexPath row]];
        [bs removeBeer:b];
        
        // Also remove the row from the table with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (([[[beerStore sharedBeerStore] allBeers] count] - 1) == 0) {
        UIAlertView *lastBeer = [[UIAlertView alloc] initWithTitle:nil message:@"Need at Least One Saved Drink" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [lastBeer show];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[beerStore sharedBeerStore] moveItemAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    beerStore *bs = [beerStore sharedBeerStore];
    NSArray *beers = [bs allBeers];
    Beer *b = [beers objectAtIndex:[indexPath row]];
    
    thirdDrinkPercent = [defaults objectForKey:@"secondaryDrinkPercentKey"];
    secondaryDrinkPercent = [defaults objectForKey:@"mainDrinkPercentKey"];
    mainDrinkPercent = [b beerPercentAlcohol];
    [defaults setObject:mainDrinkPercent forKey:@"mainDrinkPercentKey"];
    [defaults setObject:secondaryDrinkPercent forKey:@"secondaryDrinkPercentKey"];
    [defaults setObject:thirdDrinkPercent forKey:@"thirdDrinkPercentKey"];
    
    thirdDrinkSize = [defaults objectForKey:@"secondaryDrinkSizeKey"];
    secondaryDrinkSize = [defaults objectForKey:@"mainDrinkSizeKey"];
    mainDrinkSize = [b beerSize];
    [defaults setObject:mainDrinkSize forKey:@"mainDrinkSizeKey"];
    [defaults setObject:secondaryDrinkSize forKey:@"secondaryDrinkSizeKey"];
    [defaults setObject:thirdDrinkSize forKey:@"thirdDrinkSizeKey"];
    
    // Get all button titles
    thirdDrinkTitle = [defaults objectForKey:@"secondaryDrinkKey"];
    secondaryDrinkTitle = [defaults objectForKey:@"mainDrinkKey"];
    mainDrinkTitle = [NSString stringWithFormat:@"%@ %@oz", [b beerName], [b beerSize]];
    
    [defaults setObject:mainDrinkTitle forKey:@"mainDrinkKey"];
    [defaults setObject:secondaryDrinkTitle forKey:@"secondaryDrinkKey"];
    [defaults setObject:thirdDrinkTitle forKey:@"thirdDrinkKey"];
    
    // NSLog(@"Name: %@ Percent: %@ Size: %@", mainDrinkTitle, mainDrinkPercent, mainDrinkSize);

    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    // Ensure that the user is entering a valid number for the % when adding
    // a beer
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    if (tracker == 2) {
        NSString *nameText = [[alertView textFieldAtIndex:0] text];
        NSString *percentText = [[alertView textFieldAtIndex:1] text];
        if (nameText.length == 0 || percentText.length == 0 || percentText.length >= 3)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else if (tracker == 4) {
        NSString *sizeText = [[alertView textFieldAtIndex:0] text];
        NSNumber *sizeCheck = [f numberFromString:sizeText];
        if (sizeCheck == 0) {
            return NO;
        }
        else {
            return YES;
        }
    }
    else {
        return YES;
    }
}

@end
