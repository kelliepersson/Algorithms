//
//  ViewControllerModel.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/22/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^didGetPrimesDataBlock)(NSArray *primes);
@interface ViewControllerModel : NSObject

@property (nonatomic, copy) didGetPrimesDataBlock didGetPrimesData;

-(void)retrievePrimes:(NSInteger)limit;

@end
