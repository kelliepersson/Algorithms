//
//  ViewController.h
//  SieveOfEratosthenes
//
//  Created by Kellie Spears on 11/17/16.
//  Copyright © 2016 Kellie Spears. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger const LIMIT_MAX;
extern NSString *const FIND_BUTTON;
extern NSString *const LIMIT_PLACEHOLDER;
extern NSString *const TITLE_LABEL;
extern NSString *const kCalculate;
extern NSString *const kResults;

@class ViewControllerModel;
typedef NS_ENUM(NSInteger, Animation)
{
    Calculate = 0,
    Results
};
@interface ViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *limitTextField;
@property (nonatomic, weak) IBOutlet UIButton *findButton;
@property (nonatomic, strong) ViewControllerModel *model;

- (IBAction)findPrimes:(UIButton *)sender;
- (BOOL)validateLimit:(NSString *)textfield range:(NSRange)range replacement:(NSString *)string;
- (void)bindToModel;

@end

