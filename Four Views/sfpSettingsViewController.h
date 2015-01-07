//
//  sfpSettingsViewController.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sfpSettingsViewController : UIViewController

@property int weight;
@property (nonatomic) float genderConstant;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (nonatomic) NSUserDefaults *defaults;
@property (nonatomic) NSString *gender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;

- (IBAction)genderSelector:(id)sender;
- (IBAction)backToMain:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
