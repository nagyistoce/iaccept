//
//  ETDebitCardPaymentViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPaymentViewController.h"

@interface ETDebitCardPaymentViewController : UIViewController

@property (nonatomic) int orderCost;
@property (weak, nonatomic) IBOutlet UISlider *depositSlider;
@property (weak, nonatomic) IBOutlet UILabel *depositLabel;
@property (weak, nonatomic) IBOutlet UITextField *debitCartNumber;
@property (strong, nonatomic) ETPaymentViewController *parent;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

- (IBAction)pay:(id)sender;
- (IBAction)depositAmountChanged:(id)sender;


@end
