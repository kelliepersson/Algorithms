//
//  ViewControllerManager.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Prime;
typedef void(^viewControllerManagerDidGetData)(NSArray<NSNumber *>*primes);

@interface ViewControllerManager : NSObject

@property (nonatomic, copy) viewControllerManagerDidGetData didGetPrimes;

-(void)retrievePrimes:(NSInteger)limit complete:(viewControllerManagerDidGetData)complete;

@end
