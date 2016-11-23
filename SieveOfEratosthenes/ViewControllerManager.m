//
//  ViewControllerManager.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewControllerManager.h"

// Collaborators
#import "Prime.h"

@implementation ViewControllerManager

-(void)retrievePrimes:(NSInteger)limit complete:(viewControllerManagerDidGetData)complete {

    Prime *prime = [[Prime alloc] initWithLimit:limit];

    // Handle the result on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        if(complete)
            complete([prime sieve2]);
    });
}

@end

