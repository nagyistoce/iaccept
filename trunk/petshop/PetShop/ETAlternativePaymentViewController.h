//
//  ETAlternativePaymentViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETPaymentViewController.h"

@interface ETAlternativePaymentViewController : UIViewController

@property(strong,nonatomic) NSString* paymentType;
@property(nonatomic) NSInteger paymentMode; 
@property() int orderCost;
@property(strong, nonatomic) NSString* url;
@property (strong, nonatomic) ETPaymentViewController *parent;

@property (weak, nonatomic) IBOutlet UIStepper *depositStepper;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIButton *informationButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onlineInStoreChoice;

@property (weak, nonatomic) IBOutlet UILabel *paymentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositAmount;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)stepValueChanged:(id)sender;
- (IBAction)tooglePaymentMode:(id)sender;
- (IBAction)information:(id)sender;
@end
