//
//  Prime.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "Prime.h"

@interface Prime()

@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, strong) NSMutableArray<NSNumber *>*primes;

@end

@implementation Prime

-(id)initWithLimit:(NSUInteger)limit {

    self = [super init];

    if(self) {

        _limit = limit;
        _primes = nil;
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
    NSIndexSet *removeIndexes = [self.primes indexesOfObjectsPassingTest:^BOOL(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [excludePredicate evaluateWithObject:obj];
    }];
    [self.primes removeObjectsAtIndexes:removeIndexes];
}

-(NSArray<NSNumber *>*)sieve {

    // anything less than 2 is not valid limit
    if(self.limit < 2) return NULL;

    // 1 - Make a list of (odd) numbers from 2 to maximum number 'limit';
    self.primes = [[NSMutableArray alloc] init];
    [self.primes addObject:@2];

    int i = 3;
    while (i<=self.limit) {
        [self.primes addObject:[NSNumber numberWithInt:i]];
         i += 2;
    }

    // 2(a) - Start with first odd number (3), iterate through list
    NSArray *numbersSub = [self.primes subarrayWithRange:NSMakeRange(1, self.primes.count-1)];
    [numbersSub enumerateObjectsUsingBlock:^(NSNumber * _Nonnull number, NSUInteger idx, BOOL * _Nonnull stop) {

        // if the next identified prime exceeds the square root of the upper limit, all the remaining numbers in the list are prime
        if([number intValue] > sqrt(self.limit)) *stop = YES;

        [self extract:number];
    }];

    return [self.primes copy];
}

-(NSArray<NSNumber *>*)sieve2 {

    // array that holds prime numbers
    NSMutableArray<NSNumber *>*primes = [[NSMutableArray alloc] init];

    // array that holds ϕ(n) Euler's totient function for each integers k in the range 1 ≤ k ≤ n
    // :initialize phi to values of 0
    NSMutableArray<NSNumber *> *phi = [NSMutableArray array];
    for(int i=0; i<self.limit + 1; i++)
        [phi addObject:@0];

    // :set phi[1] to 1
    phi[1] = @1;

    for (NSUInteger k = 2; k <= self.limit; ++k) {

        if ([phi[k] isEqual: @0]) { // k cannot be further divided; it is prime

            phi[k] = @(k - 1); // a prime is coprime to all numbers before it
            [primes addObject:@(k)];
        }

        NSUInteger totient = [phi[k] unsignedIntegerValue];
        for(NSNumber *prime in primes) {

            NSUInteger p = [prime unsignedIntegerValue];
            NSUInteger kMultiple = k * p;

            if(kMultiple > self.limit) break;

            if (k % p) // k and p are coprime -> phi is multiplicative in this case
                phi[kMultiple] = @(totient * (p - 1));  // f(ab) = f(a) f(b)phi[p] == (p - 1)

            else {
                phi[kMultiple] = @(totient * p);
                break;
            }
        }
    }

    return primes;
}

@end
