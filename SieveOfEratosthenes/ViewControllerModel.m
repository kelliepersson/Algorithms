//
//  ViewControllerModel.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewControllerModel.h"

// Collaborators
#import "ViewControllerManager.h"

@interface ViewControllerModel()

@property (nonatomic, strong) ViewControllerManager *manager;

@end

@implementation ViewControllerModel

-(ViewControllerManager *)manager {

    if(!_manager)
        _manager = [[ViewControllerManager alloc] init];

    return _manager;
}

-(void)sendPrimes:(NSArray *)primes {
    if (self.didGetPrimesData) {

        dispatch_async(dispatch_get_main_queue(), ^{
            self.didGetPrimesData(primes);
        });
    }
}

-(void)retrievePrimes:(NSInteger)limit {

    [self.manager retrievePrimes:limit complete:^(NSArray<NSNumber *>*primes) {

            // Raise didGetDeregisterAlert
            [self sendPrimes:primes];
    }];
}

@end
