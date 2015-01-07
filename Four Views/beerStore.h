//
//  beerStore.h
//  Four Views
//
//  Created by Shawn Peters on 8/22/14.
//  Copyright (c) 2014 Shawn Peters. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Beer;

@interface beerStore : NSObject {
    NSMutableArray *allBeers;
}
// Class method
+ (beerStore *)sharedBeerStore;

- (void) removeBeer:(Beer *)b;

- (NSArray *)allBeers;
- (Beer *)createBeerWithName:(NSString *)passedName andPercent:(NSString *)passedPercent andSize:(NSString *)passedSize;
- (NSString *)beerArchivePath;
- (BOOL)saveChanges;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;

@end
