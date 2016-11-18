//
//  Prime.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prime : NSObject

-(id)initWithLimit:(NSUInteger)limit;
-(NSArray<NSNumber *>*)sieve;
-(NSArray<NSNumber *>*)sieve2;

@end
