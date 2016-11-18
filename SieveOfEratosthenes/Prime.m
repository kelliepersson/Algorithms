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
@property (nonatomic, copy) NSMutableArray<NSNumber *> *numbers;

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


-(NSArray<NSNumber *>*)extract:(NSNumber *)number {

    NSMutableArray *multiple = [[NSMutableArray alloc] init];
    for(int i=2; i<self.limit; i++) {

        int multNumber = [number intValue] * i;
        if(multNumber > self.limit) break;

        multiple[i] = [NSNumber numberWithInteger:multNumber];
    }

    return [multiple copy];
}

-(NSArray<NSNumber *>*)sieve {

    // anything less than 2 is not valid limit
    if(self.limit < 2) return NULL;

    // 1 - Make a list of (odd) numbers from 2 to maximum number 'limit';
    self.numbers = [[NSMutableArray alloc] init];
    [self.numbers addObject:[NSNumber numberWithInt:2]];

    int i = 3;
    while (i<=self.limit) {
        [self.numbers addObject:[NSNumber numberWithInt:i]];
         i += 2;
    }

    // 2 - Extract first number from the list, make a new list in which each element of the original list,
    //     including the first, is multiplied by the extracted first number; return list;
    [self.numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger idx, BOOL * _Nonnull stop) {

        NSArray *arr = [self extract:number];

        // 3 - “Subtract” the new list from the original, keeping in an output list only those numbers in the
        //     original list that do not appear in the new list.

    }];


    // 3 - “Subtract” the new list from the original, keeping in an output list only those numbers in the original list that do not appear in the new list.


    return self.numbers;
}

@end
