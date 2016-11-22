//
//  ViewController.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewController.h"

NSString *const LIMIT_LABEL = @"Please enter a number.";
NSString *const TITLE_LABEL = @"Prime Machine";

@interface ViewController ()

@property (strong, nonatomic) CAReplicatorLayer *replicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // setup animation
    self.replicator = [[CAReplicatorLayer alloc] init];
    [self resultsAnimation]; // ->[self calculateAnimation];

    // setup label
    self.limitLabel.text = LIMIT_LABEL;
    self.titleLabel.text = TITLE_LABEL;

    // setup keyboard
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];

    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    keyboardToolbar.items = @[flexBarButtonItem, doneBarButtonItem];

    // setup text field
    self.limitTextField.delegate = self;
    self.limitTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.limitTextField.inputAccessoryView	 = keyboardToolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called whenever device orientation changes.
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [self.replicator removeFromSuperlayer];

    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

        [self resultsAnimation];
    }];
}

// Called when phone keyboard is invoked from textfield
- (void)done {

    [self.limitTextField resignFirstResponder];
}

#pragma mark - animation
-(void)calculateAnimation {

    self.replicator.bounds = CGRectMake(0, 0, 60, 60);
    self.replicator.position = self.view.center;
    [self.view.layer addSublayer:self.replicator];

    CALayer *bar = [[CALayer alloc] init];
    bar.bounds = CGRectMake(0, 0, 8, 40);
    bar.position = CGPointMake(10, 75);
    bar.cornerRadius = 2;
    bar.backgroundColor = [UIColor redColor].CGColor;
    [self.replicator addSublayer:bar];

    CABasicAnimation *move = [[CABasicAnimation alloc] init];
    move.keyPath = @"position.y";
    move.toValue = @(bar.position.y - 35);
    move.duration = 0.5;
    move.autoreverses = YES;
    move.repeatCount = INFINITY;
    [bar addAnimation:move forKey:nil];

    self.replicator.instanceCount = 3;
    self.replicator.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    self.replicator.instanceDelay = 0.33;
    self.replicator.masksToBounds = YES;
}

-(void)resultsAnimation {

    self.replicator.bounds = CGRectMake(0, 0, 0, 0);
    self.replicator.backgroundColor = [UIColor whiteColor].CGColor;
    CGPoint rPoint = [self.limitTextField.superview convertPoint:self.limitTextField.frame.origin toView:self.view];
    self.replicator.position = CGPointMake(rPoint.x, rPoint.y + 35.f);
    [self.view.layer addSublayer:self.replicator];

    CALayer *dot = [[CALayer alloc] init];
    dot.bounds = CGRectMake(0,0,5,5);
    dot.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    dot.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    dot.borderWidth = 0.5;
    dot.cornerRadius = 2.5;
    dot.shouldRasterize = YES;
    dot.rasterizationScale = [[UIScreen mainScreen] scale];
    [self.replicator addSublayer:dot];

    CAKeyframeAnimation *move = [[CAKeyframeAnimation alloc] init];
    move.keyPath = @"position";
    move.path = [self star];
    move.repeatCount = INFINITY;
    move.duration = 4.0;
    [dot addAnimation:move forKey:nil];

    self.replicator.instanceCount = 20;
    self.replicator.instanceDelay = 0.1;
    self.replicator.instanceColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:1].CGColor;
    self.replicator.instanceBlueOffset = -0.03;
}

-(CGPathRef)star {

    //// Star drawing - generated using BezierCode lite
    UIBezierPath *star = [UIBezierPath bezierPath];
    [star moveToPoint:CGPointMake(23.426, 19.882)];
    [star addCurveToPoint:CGPointMake(13.297, 52.21) controlPoint1:CGPointMake(5.103, 22.644) controlPoint2:CGPointMake(-13.22, 25.405)];
    [star addCurveToPoint:CGPointMake(39.814, 72.19) controlPoint1:CGPointMake(10.167, 71.136) controlPoint2:CGPointMake(7.037, 90.061)];
    [star addCurveToPoint:CGPointMake(66.332, 52.21) controlPoint1:CGPointMake(56.203, 81.126) controlPoint2:CGPointMake(72.592, 90.061)];
    [star addCurveToPoint:CGPointMake(56.203, 19.882) controlPoint1:CGPointMake(79.591, 38.808) controlPoint2:CGPointMake(92.849, 25.405)];
    [star addCurveToPoint:CGPointMake(23.426, 19.882) controlPoint1:CGPointMake(48.009, 2.664) controlPoint2:CGPointMake(39.814, -14.555)];
    [star closePath];

    return CGPathCreateCopy(star.CGPath);
}

#pragma mark - UITextFieldDelegate methods
// Dismisses keyboard when touching outside the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Called when the text field becomes active
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}

// Called when the text field becomes inactive
- (void)textFieldDidEndEditing:(UITextField *)textField {

}

/* Called each time the user types a character on the keyboard;
 * called just before a character is displayed
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    // empty string is not valid
    if (!string.length && range.length <= 0) return NO;

    NSCharacterSet *keepSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *removeSet = [keepSet invertedSet];
    NSRange removeRange = [string rangeOfCharacterFromSet:removeSet options:NSCaseInsensitiveSearch];

    // string is not a valid number
    if (removeRange.location != NSNotFound) return NO;

    // no complaints, string is valid number
    return YES;
}

// Called when the user presses the clear button
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}


@end
