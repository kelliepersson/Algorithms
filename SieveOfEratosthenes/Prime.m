//
//  Prime.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "Prime.h"

@interface Prime()

@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *numbers;

@end

@implementation Prime

-(id)initWithLimit:(int)limit {

    self = [super init];

    if(self) {

        _limit = limit;
        _numbers = nil;
    }

    return self;
}

-(void)extract:(NSNumber *)number {

    // 2(b) - Make a new list in which each element of the list is a multiple of the passed in number
    NSMutableArray *multiple = [[NSMutableArray alloc] init];
    for(int i=0; i<self.limit; i++) {
        int multNumber = [number intValue] * (i+2);

        // only need to add values less than limit
        if(multNumber > self.limit) break;

        multiple[i] = [NSNumber numberWithInteger:multNumber];
    }

    // 3 - Exclude new list values from original list
    NSPredicate *excludePredicate = [NSPredicate predicateWithFormat:@"SELF in %@", multiple];
    NSIndexSet *removeIndexes = [self.numbers indexesOfObjectsPassingTest:^BOOL(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [excludePredicate evaluateWithObject:obj];
    }];
    [self.numbers removeObjectsAtIndexes:removeIndexes];
}

-(NSArray<NSNumber *>*)sieve {

    // anything less than 2 is not valid limit
    if(self.limit < 2) return NULL;

    // 1 - Make a list of (odd) numbers from 2 to maximum number 'limit';
    self.numbers = [[NSMutableArray alloc] init];
    [self.numbers addObject:@2];

    int i = 3;
    while (i<=self.limit) {
        [self.numbers addObject:[NSNumber numberWithInt:i]];
         i += 2;
    }

    // 2(a) - Start with first odd number (3), iterate through list
    NSArray *numbersSub = [self.numbers subarrayWithRange:NSMakeRange(1, self.numbers.count-1)];
    [numbersSub enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger idx, BOOL * _Nonnull stop) {

        // if the next identified prime exceeds the square root of the upper limit, all the remaining numbers in the list are prime
        if([number intValue] > sqrt(self.limit)) *stop = YES;

        [self extract:number];
    }];

    return [self.numbers copy];
}

@end
