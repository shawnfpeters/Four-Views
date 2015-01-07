//
//  sfpHelpViewController.m
//  Four Views
//
//  Created by Shawn Peters on 9/16/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "sfpHelpViewController.h"
#import "sfpViewController.h"

@interface sfpHelpViewController ()

@end

@implementation sfpHelpViewController
@synthesize helpText, hangoverIcon, helpImage;

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
    // Add save button to navigation bar
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"appBackground"]];
    self.navigationItem.title = @"Help";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]
                             initWithTitle:@"< Back"
                             style:UIBarButtonItemStyleBordered
                             target:self
                             action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = back;
    helpText.numberOfLines=0;
    [helpText setText:@"1. Use \"Drink List\" to select a drink or add new drinks \n2. Press \"Start\" \n3. Press the button for the corresponding drink consumed \n4. The more stars, the better you will feel tomorrow \n5. When finished drinking, press \"Stop\" \n6. The next morning, rate how you feel \n\nZero Hangover will save the rating and adjust the measurements for the next use. \n\nThe more you use Zero Hangover, the more accurately it will be able to estimate how you will feel the following day."];
    
    hangoverIcon = [UIImage imageNamed:@"ZHIcon"];
    [helpImage setImage:hangoverIcon];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)backToMain:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}



@end
