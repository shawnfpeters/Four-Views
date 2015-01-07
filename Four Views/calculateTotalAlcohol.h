//
//  calculateTotalAlcohol.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculateTotalAlcohol : NSObject

- (float) withOunces: (float) ounces withAlcPercent: (float) percentAlc;
- (void) resetPreviousAlc;

@end
