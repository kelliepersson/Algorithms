//
//  main.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/*
 
 Sieve of Eratosthenes: http://746f7574.procore.com/d6cccbb1add582bb23
 
 Pseudocode

 The sieve of Eratosthenes can be expressed in pseudocode, as follows:[7][8]

 Input: an integer n > 1

 Let A be an array of Boolean values, indexed by integers 2 to n,
 initially all set to true.

 for i = 2, 3, 4, ..., not exceeding √n:
 if A[i] is true:
 for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n :
 A[j] := false

 Output: all i such that A[i] is true.

 This algorithm produces all primes not greater than n. It includes a common optimization, which is to start enumerating the multiples of each prime i from i². The time complexity of this algorithm is O(n log log n).[8]
 Segmented sieve

 As Sorenson notes, the problem with the sieve of Eratosthenes is not the number of operations it performs but rather its memory requirements.[8] For large n, the range of primes may not fit in memory; worse, even for moderate n, its cache use is highly suboptimal. The algorithm walks through the entire array A, exhibiting almost no locality of reference.

 A solution to these problems is offered by segmented sieves, where only portions of the range are sieved at a time.[9] These have been known since the 1970s, and work as follows:[8][10]

 Divide the range 2 through n into segments of some size Δ ≤ √n.
 Find the primes up to Δ, using the "regular" sieve.
 For each Δ-sized block from √n + 1 to n, set up a Boolean array of size Δ. Eliminate the multiples of each prime p ≤ √n found in step 2.

 If Δ is chosen to be √n, the space complexity of the algorithm is O(√n), while the time complexity is the same as that of the regular sieve.[8]

 For ranges with upper limit n so large that the sieving primes below √n as required by the page segmented sieve of Eratosthenes cannot fit in memory, a slower but much more space-efficient sieve like the sieve of Sorenson can be used instead.[11]

 

 Sieve Of Euler: https://programmingpraxis.com/2011/02/25/sieve-of-euler/
 February 25, 2011

 The ancient Sieve of Eratosthenes that computes the list of prime numbers is inefficient in the sense that some composite numbers are struck out more than once; for instance, 21 is struck out by both 3 and 7. The great Swiss mathematician Leonhard Euler invented a sieve that strikes out each composite number exactly once, at the cost of some additional bookkeeping. It works like this:

 First, make a list of numbers from 2, as large as you wish; call the maximum number n.

 Second, extract the first number from the list, make a new list in which each element of the original list, including the first, is multiplied by the extracted first number.

 Third, “subtract” the new list from the original, keeping in an output list only those numbers in the original list that do not appear in the new list.

 Fourth, output the first number from the list, which is prime, and repeat the second, third and fourth steps on the reduced list excluding its first element, continuing until the input list is exhausted.

 For example, start with the list 2 3 4 5 … 30. Then the new list is 4 6 8 10 … 60. Subtracting gives the list 2 3 5 7 9 … 29. Now 2 is prime and the process repeats on the list 3 5 7 9 … 29. At the next step, the new list is 9 15 21 27 … 87, subtracting gives the list 3 5 7 11 13 … 29, now 2 and 3 are prime and the process repeats on the list 5 7 11 13 … 29. Likewise for the primes 5 and 7, and since 7 · 7 > 30, the process stops, with the remaining list 11 13 17 19 23 29, so the complete list of primes less than 30 is 2 3 5 7 11 13 17 19 23 29.

 Just as in the Sieve of Eratosthenes, you can speed up the Sieve of Euler by considering only odd numbers, by stopping once the first item in the list is greater than the square root of n, and by computing the new list in the second step only as far as n.

 Your task is to write a program that implements the Sieve of Euler, then compare its performance to the Sieve of Eratosthenes. When you are finished, you are welcome to read or run a suggested solution, or to post your own solution or discuss the exercise in the comments below.
 */

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
