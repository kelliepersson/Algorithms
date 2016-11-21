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

@end

@implementation Prime

-(id)initWithLimit:(NSInteger)limit {

    self = [super init];

    if(self) {

        _limit = limit;
    }

    return self;
}

-(NSArray<NSNumber *>*)sieve {
   
    // array that holds prime numbers
    NSMutableArray *primes = [[NSMutableArray alloc] init];
    if(self.limit < 2) return primes;

    NSMutableArray<NSNumber *> *numbers = [NSMutableArray array];
    [numbers addObject:@2];  // setup first prime

    int i = 3;
    while (i <=self.limit) {  // only even numbers
        [numbers addObject:@(i)];
         i += 2;
    }

    // keep 1st number of the set and remove from array
    for (NSUInteger i=0; i<numbers.count; i++) {

        NSUInteger prime = [numbers[0] unsignedIntegerValue];
        [primes addObject:@(prime)];
        [numbers removeObject:@(prime)];

        if(prime * prime > self.limit) break; // numbers below p^2 are all primes so if p^2 > x, we're done

        // remove number from set if it is a multiple
        NSUInteger number = [numbers[0] unsignedIntegerValue];
        for (NSInteger i = numbers.count - 1; i >= 0; i--) {

            NSUInteger product = [numbers[i] unsignedIntegerValue];
            if (!(product % prime))
                [numbers removeObjectAtIndex:i];
        }

        if(number * number > self.limit) break; // numbers below n^2 are all primes so if n^2 > x, we're done
    }

    [primes addObjectsFromArray:numbers];

    return [primes copy];
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
    if(phi.count != 0) phi[1] = @1;

    for (NSInteger k = 2; k <= self.limit; ++k) {

        if ([phi[k] isEqual: @0]) { // k cannot be further divided; it is prime

            phi[k] = @(k - 1); // a prime is coprime to all numbers before it
            [primes addObject:@(k)];
        }

        NSUInteger totient = [phi[k] unsignedIntegerValue];
        for(NSNumber *prime in primes) {

            NSUInteger p = [prime unsignedIntegerValue];
            NSUInteger kMult = k * p;

            if(kMult > self.limit) break;

            if (k % p) // k and p are coprime -> only common divisor is 1 (phi is multiplicative in this case)
                phi[kMult] = @(totient * (p - 1));  // phi[p] == (p - 1)

            else {
                phi[kMult] = @(totient * p);
                break;
            }
        }
    }

    return primes;
}

@end
