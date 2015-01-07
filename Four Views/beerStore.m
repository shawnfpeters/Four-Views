//
//  beerStore.m
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import "beerStore.h"
#import "Beer.h"

@implementation beerStore

+ (beerStore *)sharedBeerStore {
    static beerStore *sharedBeerStore = nil;
    if (!sharedBeerStore)
        sharedBeerStore = [[super allocWithZone:nil] init];
    return sharedBeerStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedBeerStore];
}

- (id)init {
    self = [super init];
    if (self) {
        // Load archived data
        NSString *path = [self beerArchivePath];
        allBeers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hasn't been saved previously, create a new empty one
        if (!allBeers) {
            allBeers = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)allBeers {
    return allBeers;
}

- (NSString *)beerArchivePath {
    // Get array of all available paths in the filesystem that meet the criteria of the arguments - in iOS the last two arguments are always the same
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSLog(@"Document Directories: %@", documentDirectories);
    // Get one and only document directory from that list. iOS will only have one return value in the array, but OS X would have multiple
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"beers.archive"];
}

- (BOOL)saveChanges {
    // returns success or failure
    NSString *path  = [self beerArchivePath];
    // NSLog(@"Path: %@", path);
    
    // archiveRootObject saves every single beer in allBeers to the beerArchivePath
    return [NSKeyedArchiver archiveRootObject:allBeers toFile:path];
}

- (Beer *)createBeerWithName:(NSString *)passedName andPercent:(NSString *)passedPercent andSize:(NSString *)passedSize{
    Beer *b = [[Beer alloc] initWithBeerName:passedName percentAlc:passedPercent sizeOz:passedSize];
    [allBeers addObject:b];
    return b;
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }
    
    // Get pointer to object being moved so it can be reinserted
    Beer *b = [allBeers objectAtIndex:from];
    
    // Remove b from array
    [allBeers removeObjectAtIndex:from];
    
    // Insert b into array in new location
    [allBeers insertObject:b atIndex:to];
    
}

- (void)removeBeer:(Beer *)b {
    [allBeers removeObjectIdenticalTo:b];
}


@end
