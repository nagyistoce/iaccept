//
//  ETPaymentViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPaymentViewController.h"

@interface ETCreditCardPaymentViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (unsafe_unretained, nonatomic) IBOutlet UIPickerView *cardTypePicker;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *creditCardTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UIDatePicker *expirationDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UISlider *depositSlider;
@property (weak, nonatomic) IBOutlet UILabel *depositValueLabel;
@property (nonatomic) int orderCost;

@property (strong, nonatomic) ETPaymentViewController *parent;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)pay:(id)sender;
- (IBAction)dateChanged:(id)sender;

@end
