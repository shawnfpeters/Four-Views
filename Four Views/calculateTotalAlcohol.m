//
//  calculateTotalAlcohol.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "calculateTotalAlcohol.h"

@implementation calculateTotalAlcohol

float previousAlcohol = 0;

// Reset when the night has been saved
- (void) resetPreviousAlc {
    previousAlcohol = 0;
}

-(float) withOunces: (float) ounces withAlcPercent: (float) percentAlc {
    
    // Calculate new value for total alcohol
    float totalAlcohol = previousAlcohol + (ounces * percentAlc * 0.01);
    
    // Update previous alcohol's value for the next calculation
    previousAlcohol = totalAlcohol;
    
    return totalAlcohol;
}

@end
