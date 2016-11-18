//
//  SieveOfEratosthenesTests.m
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

@interface SieveOfEratosthenesTests : XCTestCase {

    Prime *sut;
}

@end

@implementation SieveOfEratosthenesTests

- (void)setUp {
    [super setUp];

    sut = [[Prime alloc] initWithLimit:30];
}

- (void)tearDown {

    // deallocate sut
    sut = nil;

    [super tearDown];
}

- (void)testPrime_IsNotNil {

    // then
    assertThat(sut, is(notNilValue()));
}

- (void)test_Prime_IsNULL_IfLimit_IsLessThan_2 {

    // given
    Prime *prime = [[Prime alloc] initWithLimit:1];

    // then
    assert([prime sieve] == NULL);
}

- (void)test_Prime_IfLimit_IsGreaterThan_2 {

    // then
    assertThat([sut sieve], is(equalTo(@[@2, @3, @5, @7, @11, @13, @17, @19, @23, @29])));
}

@end
