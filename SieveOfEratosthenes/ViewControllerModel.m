//
//  ViewControllerModel.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewControllerModel.h"

// Collaborators
#import "Prime.h"

@implementation ViewControllerModel

-(void)sendPrimes:(NSArray *)primes {
    if (self.didGetPrimesData) {

        dispatch_async(dispatch_get_main_queue(), ^{
            self.didGetPrimesData(primes);
        });
    }
}

-(void)retrievePrimes:(NSInteger)limit {

    // Alloc user
    Prime *prime = [[Prime alloc] initWithLimit:limit];

    // Raise didGetDeregisterAlert
    [self sendPrimes:[prime sieve2]];
}

@end
