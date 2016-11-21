//
//  ViewController.m
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import "ViewController.h"

NSString *const LIMIT_LABEL = @"Please enter a number.";

@interface ViewController ()

@property (strong, nonatomic) CAReplicatorLayer *replicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self animation];

    // setup label
    self.limitLabel.text = LIMIT_LABEL;

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

    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.replicator.position = self.view.center;
    }];
}

// Called when phone keyboard is invoked from textfield
- (void)done {

    [self.limitTextField resignFirstResponder];
}

#pragma mark - animation
-(void)animation {

    self.replicator = [[CAReplicatorLayer alloc] init];
    self.replicator.bounds = CGRectMake(0, 0, 60, 60);
    self.replicator.position = self.view.center;
    self.replicator.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.view.layer addSublayer:self.replicator];
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
