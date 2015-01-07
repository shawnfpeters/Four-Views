//
//  compareBAC.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "compareBAC.h"

@implementation compareBAC

@synthesize oneStarAverage, twoStarAverage, threeStarAverage, fourStarAverage, fiveStarAverage;
@synthesize hangoverStars;

- (UIImage *) withCurrentBAC: (float) currentBac {
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    oneStarAverage = [defaults floatForKey:@"averageBACKey1"];
    twoStarAverage = [defaults floatForKey:@"averageBACKey2"];
    threeStarAverage = [defaults floatForKey:@"averageBACKey3"];
    fourStarAverage = [defaults floatForKey:@"averageBACKey4"];
    fiveStarAverage = [defaults floatForKey:@"averageBACKey5"];
    
    float divideOne = ((oneStarAverage + twoStarAverage) / 2);
    float divideTwo = ((twoStarAverage + threeStarAverage) / 2);
    float divideThree = ((threeStarAverage + fourStarAverage) / 2);
    float divideFour = ((fourStarAverage + fiveStarAverage) / 2);
    
    if (divideOne <= currentBac) {
        // one star hangover logic
        hangoverStars = [UIImage imageNamed:@"1star"];
        return hangoverStars;
    }
    
    else if (divideTwo <= currentBac && currentBac < divideOne) {
        //two star logic
        hangoverStars = [UIImage imageNamed:@"2stars"];
        return hangoverStars;
    }
    
    else if (divideThree <= currentBac && currentBac < divideTwo) {
        // three star logic
        hangoverStars = [UIImage imageNamed:@"3stars"];
        return hangoverStars;
    }
    
    else if (divideFour <= currentBac && currentBac < divideThree) {
        //four star logic
        hangoverStars = [UIImage imageNamed:@"4stars"];
        return hangoverStars;
    }
    
    else if (currentBac < divideFour) {
        // five star logic
        hangoverStars = [UIImage imageNamed:@"5stars"];
        return hangoverStars;
    }
    
    else {
        //NSLog(@"Error getting image.");
        return nil;
    }
}

@end
