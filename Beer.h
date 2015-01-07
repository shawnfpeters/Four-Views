//
//  Beer.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject <NSCoding>

@property (nonatomic, copy) NSString *beerName;
@property (nonatomic, copy) NSString *beerPercentAlcohol;
@property (nonatomic, copy) NSString *beerSize;

- (id)initWithBeerName:(NSString *)name percentAlc:(NSString *)percent sizeOz:(NSString *)size;

@end
