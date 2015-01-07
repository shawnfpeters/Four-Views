//
//  verifyBounds.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "verifyBounds.h"

@implementation verifyBounds
@synthesize averageBACArray, arrayOfArrays, sortedArray;

- (void) checkAverages {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    averageBACArray = [[NSMutableArray alloc] init];
    arrayOfArrays = [[NSMutableArray alloc] init];
    sortedArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 6; i++) {
        
        // get each component's defaults key
        NSString *compAvgBACKey = [NSString stringWithFormat:@"averageBACKey%i", i];
        NSString *compIndexKey = [NSString stringWithFormat:@"indexKey%i", i];
        NSString *compTotalBACKey = [NSString stringWithFormat:@"totalBACKey%i", i];
        
        // retrieve the current values
        float compAvgBACFloat = [defaults floatForKey:compAvgBACKey];
        int compIndexInt = [defaults floatForKey:compIndexKey];
        float compTotalBACFloat = [defaults floatForKey:compTotalBACKey];
        
        // make them strings so they can be added to an array
        NSString *compAvgBAC = [NSString stringWithFormat:@"%f", compAvgBACFloat];
        NSString *compIndex = [NSString stringWithFormat:@"%i", compIndexInt];
        NSString *compTotalBAC = [NSString stringWithFormat:@"%f", compTotalBACFloat];
        
        NSArray *array = [[NSArray alloc] initWithObjects:compAvgBAC, compIndex, compTotalBAC, nil];
        [arrayOfArrays addObject:array];
        
    }
    
    [arrayOfArrays sortUsingComparator:^(id a, id b) {
        return [b[0] compare:a[0]];
    }];
    
    for (int j = 1; j < 6; j++) {
        NSArray *arrayTwo = [arrayOfArrays objectAtIndex:(j - 1)];
        
        // get each component's defaults key
        NSString *compAvgBACKey = [NSString stringWithFormat:@"averageBACKey%i", j];
        NSString *compIndexKey = [NSString stringWithFormat:@"indexKey%i", j];
        NSString *compTotalBACKey = [NSString stringWithFormat:@"totalBACKey%i", j];
        
        float sortedAvgBAC = [[arrayTwo objectAtIndex:0] floatValue];
        NSInteger sortedIndex = [[arrayTwo objectAtIndex:1] integerValue];
        float sortedTotalBAC = [[arrayTwo objectAtIndex:2] floatValue];
        
        [defaults setFloat:sortedAvgBAC forKey:compAvgBACKey];
        [defaults setInteger:sortedIndex forKey:compIndexKey];
        [defaults setFloat:sortedTotalBAC forKey:compTotalBACKey];
        
        // NSLog(@"Rating: %i, sortedAvgBAC: %f, sortedIndex: %li, sortedTotalBAC: %f", j, sortedAvgBAC, (long)sortedIndex, sortedTotalBAC);
    }
}

@end
