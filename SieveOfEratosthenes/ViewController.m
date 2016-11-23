//
//  ViewController.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewController.h"

// Collaborator
#import "ViewControllerModel.h"

NSInteger const LIMIT_MAX = 1000000;
NSString *const FIND_BUTTON = @"FIND";
NSString *const LIMIT_PLACEHOLDER = @"ENTER LIMIT (BETWEEN 1-1000000)";
NSString *const TITLE_LABEL = @"Prime Time";
NSString *const kCalculate = @"Calculate";
NSString *const kResults = @"Results";

@interface ViewController ()

@property (nonatomic, strong) CAReplicatorLayer *replicator;
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, assign) Animation animation;

@end

@implementation ViewController

-(ViewControllerModel *)model {

    if(!_model)
        _model = [[ViewControllerModel alloc] init];

    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // setup model
    [self bindToModel];

    // setup animation
    self.replicator = [[CAReplicatorLayer alloc] init];
    self.layer = [[CALayer alloc] init];

    // setup label
    self.titleLabel.text = TITLE_LABEL;

    // setup button
    [self.findButton setTitle:FIND_BUTTON forState:UIControlStateNormal];
    self.findButton.enabled = NO;

    // setup keyboard
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];

    UIBarButtonItem *flexBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    keyboardToolbar.items = @[flexBarButtonItem, doneBarButtonItem];

    // setup text field
    self.limitTextField.delegate = self;
    self.limitTextField.placeholder = LIMIT_PLACEHOLDER;
    self.limitTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.limitTextField.inputAccessoryView = keyboardToolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Called whenever device orientation changes.
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

        [self startAnimation];
    }];
}

#pragma mark - animation
-(void)calculateAnimation {

    // set animation
    self.animation = Calculate;

    self.replicator.bounds = CGRectMake(0, 0, 60, 60);
    CGFloat adjustedHeight = self.replicator.bounds.size.height/2;
    CGFloat adjustedWidth = self.limitTextField.frame.size.width + 35.f;
    CGPoint endPoint = CGPointMake(self.limitTextField.frame.origin.x + adjustedWidth , self.limitTextField.frame.origin.y - adjustedHeight);
    CGPoint rPoint = [self.limitTextField.superview convertPoint:endPoint toView:self.view];
    self.replicator.position = CGPointMake(rPoint.x, rPoint.y + 35.f);
    [self.view.layer addSublayer:self.replicator];

    self.layer.bounds = CGRectMake(0, 0, 8, 40);
    self.layer.position = CGPointMake(10, 75);
    self.layer.cornerRadius = 2;
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    [self.replicator addSublayer:self.layer];

    CABasicAnimation *move = [[CABasicAnimation alloc] init];
    move.keyPath = @"position.y";
    move.toValue = @(self.layer.position.y - 35);
    move.duration = 0.5;
    move.autoreverses = YES;
    move.repeatCount = INFINITY;
    [self.layer addAnimation:move forKey:kCalculate];

    self.replicator.instanceCount = 3;
    self.replicator.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);
    self.replicator.instanceDelay = 0.33;
    self.replicator.masksToBounds = YES;
}

-(void)resultsAnimation {

    // set animation
    self.animation = Results;

    self.replicator.bounds = CGRectMake(0, 0, 0, 0);
    CGFloat adjustedHeight = self.replicator.bounds.size.height/2;
    CGFloat adjustedWidth = self.limitTextField.frame.size.width + 35.f;
    CGPoint endPoint = CGPointMake(self.limitTextField.frame.origin.x + adjustedWidth , self.limitTextField.frame.origin.y - adjustedHeight);
    CGPoint rPoint = [self.limitTextField.superview convertPoint:endPoint toView:self.view];
    self.replicator.position = CGPointMake(rPoint.x, rPoint.y + 35.f);
    self.replicator.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:self.replicator];

    self.layer.bounds = CGRectMake(0,0,5,5);
    self.layer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2.5;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    [self.replicator addSublayer:self.layer];

    CAKeyframeAnimation *move = [[CAKeyframeAnimation alloc] init];
    move.keyPath = @"position";
    move.path = [self star];
    move.repeatCount = INFINITY;
    move.duration = 4.0;
    [self.layer addAnimation:move forKey:kResults];

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

    return star.CGPath;
}

#pragma mark - UITextFieldDelegate methods
// Dismisses keyboard when touching outside the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Called when the text field becomes active
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    // disable findButton
    self.findButton.enabled = NO;
}

// Called when the text field becomes inactive
- (void)textFieldDidEndEditing:(UITextField *)textField {

    if((int)self.limitTextField.text.length >= 0) self.findButton.enabled = YES;
}

/* Called each time the user types a character on the keyboard;
 * called just before a character is displayed
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return [self validateLimit:textField.text range:range replacement:string];
}

// Called when the user presses the clear button
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

#pragma mark - action methods
- (IBAction)findPrimes:(UIButton *)sender {

    // disable findButton
    self.findButton.enabled = NO;

    // reset animation
    [self.layer removeAnimationForKey:kResults];
    [self calculateAnimation];

    // model call
    [self.model retrievePrimes:[self.limitTextField.text integerValue]];
}

-( BOOL)validateLimit:(NSString *)textfield range:(NSRange)range replacement:(NSString *)string {

    // empty string is not valid
    if (!string.length && range.length <= 0) return NO;

    // remove leading zero(s)
    if ([string hasPrefix:@"0"] && !textfield.length) return NO;

    NSCharacterSet *keepSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *removeSet = [keepSet invertedSet];
    NSRange removeRange = [string rangeOfCharacterFromSet:removeSet options:NSCaseInsensitiveSearch];

    // string is not a valid number
    if (removeRange.location != NSNotFound) return NO;

    // no complaints, string is valid number
    return [[textfield stringByAppendingString:string] integerValue] <= LIMIT_MAX;
}

-(void)bindToModel {
    self.model.didGetPrimesData = [self modelDidGetPrimesData];
}

-(didGetPrimesDataBlock)modelDidGetPrimesData {
    return ^(NSArray<NSNumber *>*primes) {

        // enable findButton
        self.findButton.enabled = YES;

        // reset animation
        [self.layer removeAnimationForKey:kCalculate];
        [self resultsAnimation];
    };
}

#pragma mark - helper method(s)
// Called when phone keyboard is invoked from textfield
- (void)done {

    [self.limitTextField resignFirstResponder];
}

-(void)startAnimation {

    // current animation is calculate
    if(self.animation == Calculate) [self calculateAnimation];

    // current animation is results
    else if (self.animation == Results) [self resultsAnimation];
}

@end
