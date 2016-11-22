//
//  ViewControllerTest.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/19/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

// Collaborators
#import <XCTest/XCTest.h>
#import <OCHamcrest.h>

// Class under test
#import "ViewController.h"

@interface ViewControllerTest : XCTestCase {

    UIWindow *window;
    UIStoryboard *storyBoard;
    ViewController *sut;
}

@end

@implementation ViewControllerTest

- (void)setUp {
    [super setUp];

    // initialize window
    window = [[UIWindow alloc] init];

    // setup sut
    storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    sut = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];

    // Add the view controller's view to the window and display
    window.rootViewController = sut;
    [window addSubview:sut.view];
}

-(void)tearDown {

    // ensure collaborators are deallocated;
    window = nil;

    // ensure system under test is deallocated;
    sut = nil;

    [super tearDown];
}

#pragma mark - IBOutlet - limitLabel
-(void)test_LimitLabel_ShouldBeConnected {

    // then
    assertThat(sut.limitLabel, is(notNilValue()));
}

-(void)test_LimitLabel_sOfCorrectType {

    // then
    assertThat(@([sut.limitLabel isKindOfClass:[UILabel class]]), is(@YES));
}

#pragma mark - IBOutlet - limitTextField
-(void)test_LimitTextField_ShouldBeConnected {

    // then
    assertThat(sut.limitTextField, is(notNilValue()));
}

-(void)test_LimitTextField_IsOfCorrectType {

    // then
    assertThat(@([sut.limitTextField isKindOfClass:[UITextField class]]), is(@YES));
}

-(void)test_LimitTextField_IsUsingNumberPadKeyboard {

    // then
    assertThat(@(sut.limitTextField.keyboardType), is(@(UIKeyboardTypeNumberPad)));
}

@end
