//
//  calculateBAC.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculateBAC : NSObject

- (float) bacCalculatorWithAlcohol: (float) totalAlcohol withWeight: (int) weight withGender: (float) genderConstant withTime: (float) time;

@end
