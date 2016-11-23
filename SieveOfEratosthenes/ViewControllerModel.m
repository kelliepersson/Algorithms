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

-(void)retrievePrimes:(NSInteger)limit complete:(void(^)(NSArray<NSNumber *>*))complete {

    // Alloc user
    Prime *prime = [[Prime alloc] initWithLimit:limit];

    // Handle the result on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{

        // Raise didGetPrimesData
        complete([[prime sieve2] copy]);
    });
}

@end
