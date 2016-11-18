//
//  Prime.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "math.h"

@interface Prime : NSObject

-(id)initWithLimit:(int)limit;
-(NSArray<NSNumber *>*)sieve;

@end
