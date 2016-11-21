//
//  PrimeTest.m
//  SieveOfEratosthenesTests
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

// Collaborators
#import <XCTest/XCTest.h>
#import <OCHamcrest.h>

// Class under test
#import "Prime.h"

@interface PrimeTest : XCTestCase {

    Prime *sut;
}

@end

@implementation PrimeTest

- (void)setUp {
    [super setUp];

    sut = [[Prime alloc] initWithLimit:30];
}

- (void)tearDown {

    // deallocate sut
    sut = nil;

    [super tearDown];
}

- (void)test_Prime_IsNotNil {

    // then	
    assertThat(sut, is(notNilValue()));
}

#pragma mark - Sieve tests
- (void)test_Sieve_IfLimit_IsNotSet {

    // given
    sut = [[Prime alloc] init];

    // then
    assertThat(@([sut sieve].count), is(@0));
}

- (void)test_Sieve_IfLimit_IsLessThan_2 {

    // given
    sut = [[Prime alloc] initWithLimit:-3];

    // then
    assertThat(@([sut sieve].count), is(@0));
}

- (void)test_Sieve_IfLimit_IsGreaterThan_2 {

    // then
    assertThat([sut sieve], is(equalTo(@[@2, @3, @5, @7, @11, @13, @17, @19, @23, @29])));
}

#pragma mark - Sieve 2 tests
- (void)test_Sieve2_IfLimit_IsNotSet {

    // given
    sut = [[Prime alloc] init];

    // then
    assertThat(@([sut sieve2].count), is(@0));
}

- (void)test_Sieve2_IfLimit_IsLessThan_2 {

    // given
    sut = [[Prime alloc] initWithLimit:-15];

    // then
    assertThat(@([sut sieve2].count), is(@0));
}

- (void)test_Sieve2_IfLimit_IsGreaterThan_2 {

    // then
    assertThat([sut sieve2], is(equalTo(@[@2, @3, @5, @7, @11, @13, @17, @19, @23, @29])));
}

#pragma mark - performance tests
// For smaller limit (N), sieve is faster
- (void)test_SieveOfEratosthenesPerformance {
    // This is an example of a performance test case.

    sut = [[Prime alloc] initWithLimit:100000];
    [self measureBlock:^{

        [sut sieve];
    }];
}

// For larger limit (N), sieve2 is faster and memory efficient
- (void)test_EulerSievePerformance {
    // This is an example of a performance test case.

    Prime *prime = [[Prime alloc] initWithLimit:100000];
    [self measureBlock:^{

        [prime sieve2];
    }];
}

@end
