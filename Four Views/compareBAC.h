//
//  compareBAC.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface compareBAC : NSObject

@property float oneStarAverage, twoStarAverage, threeStarAverage, fourStarAverage, fiveStarAverage;
@property (nonatomic) UIImage *hangoverStars;

- (UIImage *) withCurrentBAC: (float) currentBac;

@end
