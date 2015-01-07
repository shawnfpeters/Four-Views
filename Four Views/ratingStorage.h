//
//  ratingStorage.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ratingStorage : NSObject

@property (nonatomic) float totalBAC;
@property (nonatomic) float averageBAC;
@property (nonatomic) int index;

- (void)withBAC: (float) bac withRating: (int) rating;

@end
