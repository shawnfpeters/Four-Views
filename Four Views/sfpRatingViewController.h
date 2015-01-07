//
//  sfpRatingViewController.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ratingStorage;
@class verifyBounds;

@interface sfpRatingViewController : UIViewController

@property ratingStorage *storeRating;
@property verifyBounds *verifyAverageOrder;

// Total BACs and average BACs for each rating
@property (nonatomic) float newBAC;

@property (weak, nonatomic) IBOutlet UILabel *dateDisplay;

@property (weak, nonatomic) IBOutlet UIButton *oneStar;
@property (weak, nonatomic) IBOutlet UIButton *twoStars;
@property (weak, nonatomic) IBOutlet UIButton *threeStars;
@property (weak, nonatomic) IBOutlet UIButton *fourStars;
@property (weak, nonatomic) IBOutlet UIButton *fiveStars;
@property (weak, nonatomic) IBOutlet UIButton *deleteAll;
@property (weak, nonatomic) IBOutlet UIButton *deleteNight;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
