//
//  ETPaymentViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETCreditCardPaymentViewController.h"
#import "PetDAO.h"
#import "ShoppingCart.h"
#import "RefreshableViewController.h"
#import "Util.h"

@interface ETCreditCardPaymentViewController() {
    BOOL validCardType;
    BOOL validCardNumber;
    BOOL validDate;
}

-(void)updatePayButtonStatus;
@end

@implementation ETCreditCardPaymentViewController
@synthesize cardTypePicker;
@synthesize creditCardTextField;
@synthesize expirationDatePicker;
@synthesize payButton;
@synthesize depositSlider =_depositSlider;
@synthesize depositValueLabel = _depositValueLabel;
@synthesize parent = _parent;
@synthesize orderCost = _orderCost;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self setTitle:@"Credit"];

    validCardType = NO;
    validCardNumber = NO;
    validDate = NO;
    
    [payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self updatePayButtonStatus];
    
    [_depositSlider setMinimumValue:(_orderCost * 0.1)];
    [_depositSlider setMaximumValue:_orderCost];
    [_depositSlider sendActionsForControlEvents:UIControlEventValueChanged];
    
    _depositValueLabel.text = [[NSNumber numberWithFloat:floor(_depositSlider.minimumValue)] stringValue];
}

- (void)viewDidUnload
{
    [self setCardTypePicker:nil];
    [self setCreditCardTextField:nil];
    [self setExpirationDatePicker:nil];
    [self setPayButton:nil];
    [self setDepositSlider:nil];
    [self setDepositValueLabel:nil];
    [super viewDidUnload];
}



-(void)updatePayButtonStatus {
    if (validCardNumber && validCardType && validDate) {
        [payButton setEnabled:YES];
    } else {
        [payButton setEnabled:NO];

    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)sliderValueChanged:(id)sender {
    _depositValueLabel.text = [[NSNumber numberWithFloat:floor([_depositSlider value])] stringValue];
}

- (IBAction)pay:(id)sender {
    ShoppingCart* shoppingCart = [PetDAO shoppingCart];
    [shoppingCart removePets:[shoppingCart pets]];
    
    id<RefreshableViewController> rootViewController = (id<RefreshableViewController>)[[self.navigationController viewControllers] objectAtIndex:0];
    [rootViewController refresh];
    
    [_parent pushViewPaymentDone];
}

- (IBAction)dateChanged:(id)sender {
    NSDate* date = [(UIDatePicker*)sender date];
    
    if([date compare:[[NSDate alloc] initWithTimeIntervalSinceNow:0]] == NSOrderedDescending) {
        validDate = YES;
    } else {
        validDate = NO;
    }
    [self updatePayButtonStatus];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"Select a card";
    } else if (row == 1) {
        return @"Visa";
    } else if (row == 2) {
        return @"MasterCard";
    } else if (row == 3) {
        return @"Discover";
    } else {
        return @"Other";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([creditCardTextField.text length] <= 1) {
        if (row == 0) {
            creditCardTextField.text = @"";
        } else if (row == 1) {
            creditCardTextField.text = @"4";
        } else if (row == 2) {
            creditCardTextField.text = @"5";
        } else if (row == 3) {
            creditCardTextField.text = @"6";
        } else {
            creditCardTextField.text = @"3";
        }
    }
    
    if (row > 0) {
        validCardType = YES;
    } else {
        validCardType = NO;
    }
        
    [self updatePayButtonStatus];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString* originalCardNumber = [textField text];
    
    NSMutableString* plainNumber = [NSMutableString stringWithString:[originalCardNumber stringByReplacingOccurrencesOfString:@" " withString:@""]];
    validCardNumber = [Util cardNumberValid:plainNumber];
    
    if (validCardNumber) {
        [textField setBackgroundColor:[UIColor clearColor]];
        textField.text = [Util formatCardNumber:plainNumber];
    } else {
        [textField setBackgroundColor:[UIColor redColor]];
    }
    
    [self updatePayButtonStatus];
}

@end
