//
//  calculateBAC.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "calculateBAC.h"

@implementation calculateBAC

- (float) bacCalculatorWithAlcohol: (float) totalAlcohol withWeight: (int) weight withGender: (float) genderConstant withTime: (float) time {
    
    float bac = totalAlcohol * ((23.6588) / (weight * 4.53592 * genderConstant)) - (0.015 * time);
    
    //float bac = ((0.8 * ounces * 29.5735 * percent) / (weight * 0.453592 * 10 * genderConstant)) - (0.015 * time);  Time measured in hours
    
    return bac;
    
}

@end
