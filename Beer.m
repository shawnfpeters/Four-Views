//
//  Beer.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "Beer.h"

@implementation Beer

@synthesize beerName;
@synthesize beerPercentAlcohol;
@synthesize beerSize;


- (id)initWithBeerName:(NSString *)name percentAlc:(NSString *)percent sizeOz:(NSString *)size{
    self = [super init];
    if (self) {
        [self setBeerName:name];
        [self setBeerPercentAlcohol:percent];
        [self setBeerSize:size];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // Make beer objects NSCoding compliant so they can be saved and loaded via archiving
    self = [super init];
    if (self) {
        [self setBeerName:[aDecoder decodeObjectForKey:@"beerName"]];
        [self setBeerPercentAlcohol:[aDecoder decodeObjectForKey:@"beerPercentAlcohol"]];
        [self setBeerSize:[aDecoder decodeObjectForKey:@"beerSize"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    // Make beer objects NSCoding compliant so they can be saved and loaded via archiving
    [aCoder encodeObject:beerName forKey:@"beerName"];
    [aCoder encodeObject:beerPercentAlcohol forKey:@"beerPercentAlcohol"];
    [aCoder encodeObject:beerSize forKey:@"beerSize"];
    
}

@end
