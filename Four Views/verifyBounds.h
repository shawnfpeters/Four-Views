//
//  verifyBounds.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface verifyBounds : NSObject

@property (nonatomic) NSMutableArray *averageBACArray;
@property (nonatomic) NSMutableArray *arrayOfArrays;
@property (nonatomic) NSMutableArray *sortedArray;

- (void)checkAverages;

@end
