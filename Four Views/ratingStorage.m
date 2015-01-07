//
//  ratingStorage.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "ratingStorage.h"

@implementation ratingStorage
@synthesize totalBAC, index, averageBAC;

- (void)withBAC:(float) bac withRating:(int) rating {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *totalBACKey = [NSString stringWithFormat:@"totalBACKey%i", rating];
    NSString *indexKey = [NSString stringWithFormat:@"indexKey%i", rating];
    NSString *averageBACKey = [NSString stringWithFormat:@"averageBACKey%i", rating];
    
    totalBAC = [defaults floatForKey:totalBACKey];
    totalBAC = totalBAC + bac;
    [defaults setFloat:totalBAC forKey:totalBACKey];
    
    index = [defaults integerForKey:indexKey];
    index = index + 1;
    [defaults setInteger:index forKey:indexKey];
    
    averageBAC = [defaults floatForKey:averageBACKey];
    averageBAC = (totalBAC / index);
    [defaults setFloat:averageBAC forKey:averageBACKey];
    
    [defaults synchronize];
    
}

@end
