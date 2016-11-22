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

#pragma mark - IBOutlet - titleLabel
-(void)test_titleLabel_ShouldBeConnected {

    // then
    assertThat(sut.titleLabel, is(notNilValue()));
}

-(void)test_titleLabel_IsOfCorrectType {

    // then
    assertThat(@([sut.titleLabel isKindOfClass:[UILabel class]]), is(@YES));
}

-(void)test_titleLabel_IsCorrectlyLabeled {

    // then
    assertThat(sut.titleLabel.text, is(@"Prime Time"));
}

#pragma mark - IBOutlet - limitTextField
-(void)test_limitTextField_ShouldBeConnected {

    // then
    assertThat(sut.limitTextField, is(notNilValue()));
}

-(void)test_limitTextField_IsOfCorrectType {

    // then
    assertThat(@([sut.limitTextField isKindOfClass:[UITextField class]]), is(@YES));
}

-(void)test_limitTextField_HasPlaceholder {

    // then
    assertThat(sut.limitTextField.placeholder, is(@"ENTER LIMIT (BETWEEN 1-1000000)"));
}

-(void)test_limitTextField_IsUsingNumberPadKeyboard {

    // then
    assertThat(@(sut.limitTextField.keyboardType), is(@(UIKeyboardTypeNumberPad)));
}

#pragma mark - IBOutlet - findButton
-(void)test_findButton_ShouldBeConnected {

    // then
    assertThat(sut.findButton, is(notNilValue()));
}

-(void)test_findButton_IsOfCorrectType {

    // then
    assertThat(@([sut.findButton isKindOfClass:[UIButton class]]), is(@YES));
}

- (void)test_findButton_IsCorrectlyLabeled {

    // then
    assertThat(sut.findButton.currentTitle, is(@"FIND"));
}

- (void)test_findButton_Action {

    // then
    assertThat([[sut findButton] actionsForTarget:sut forControlEvent:UIControlEventTouchUpInside], contains(@"findPrimes:", nil));
}

#pragma mark - validateLimit tests
-(void)test_ValidateLimitReplacement_ReturnsNO_WhenSingleCharacterIsNonDigit {

    // given
    NSString *string = @"A";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@NO));
}

-(void)test_ValidateLimitReplacement_ReturnsNO_WhenFirstCharacterEnteredIs_0 {

    // given
    NSString *string = @"0";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@NO));
}

-(void)test_ValidateLimitReplacement_ReturnsYES_WhenSubsequentCharacterEnteredIs_0 {

    // given
    NSString *string = @"0";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"1" range:range replacement:string]), is(@YES));
}

-(void)test_ValidateLimitReplacement_ReturnsNO_WhenMultipleCharactersContainNonDigits {

    // given
    NSString *string = @"1A45Ds ";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@NO));
}

-(void)test_ValidateLimitReplacement_ReturnsYES_WhenMultipleCharactersInRange {

    // given
    NSString *string = @"999000";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@YES));
}

-(void)test_ValidateLimitReplacement_ReturnsNO_WhenMultipleCharacterBeginsWith_0 {

    // given
    NSString *string = @"0001";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@NO));
}

-(void)test_ValidateLimitReplacement_ReturnsNO_WhenMultipleCharactersEvaluateToNumber_WithinRange {

    // given
    NSString *string = @"1000000";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@YES));
}

-(void)test_ValidateLimitReplacement_ReturnsNO_WhenMultipleCharactersEvaluateToNumber_OutOfRange {

    // given
    NSString *string = @"1000001";
    NSRange range = [string rangeOfString:string];

    // then
    assertThat(@([sut validateLimit:@"" range:range replacement:string]), is(@NO));
}

@end
