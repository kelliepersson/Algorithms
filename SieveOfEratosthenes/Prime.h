//
//  Prime.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prime : NSObject

-(id)initWithLimit:(NSInteger)limit;

/*
 * Implementation of Sieve of Eratosthenes (Euler's Sieve):http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Euler.27s_sieve
 *
 * (1) starts with a list of numbers from 2 to n in order. 
 * 
 * (2) on each step the first element is identified as the next prime (placed in prime array) and removed from the working sequence. 
 *     The results of multiplying this prime with each element of the remaining list elements are marked in the list for subsequent deletion and
 *     removed from the working sequence.  After which the process is repeated.
 *
 * (3)  when the next identified prime exceeds the square root of the upper limit (prime * prime > limit), all the remaining numbers in the list are prime.
 */
-(NSArray<NSNumber *>*)sieve;

/*
 * Linear time Euler's Totient Function:https://en.wikipedia.org/wiki/Euler's_totient_function#Euler.27s_product_formula 
 *                                      http://stackoverflow.com/questions/34260399/linear-time-eulers-totient-function-calculation
 *
 * The computation of the values for phi(k) has to consider three different cases:
 *
 * (1) k is prime: phi(k) = k - 1, which is trivial
 *
 * (2) k = m * p with m and p coprime and p prime: phi(k) = phi(m * p) = phi(m) * phi(p) = phi(m) * (p - 1)
 *
 * (3) k = m * p with m = m' * p^n and m' and p coprime and p prime: phi(k) = phi(m) * p
 */
-(NSArray<NSNumber *>*)sieve2;

@end
