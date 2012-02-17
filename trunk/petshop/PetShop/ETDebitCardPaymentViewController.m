//
//  ETDebitCardPaymentViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETDebitCardPaymentViewController.h"
#import "PetDAO.h"
#import "ShoppingCart.h"
#import "RefreshableViewController.h"
#import "Util.h"

@interface ETDebitCardPaymentViewController() {
    BOOL validCardNumber;
}

-(void)updatePayButtonStatus;
@end

@implementation ETDebitCardPaymentViewController

@synthesize depositSlider = _depositSlider;
@synthesize depositLabel = _depositLabel;
@synthesize debitCartNumber = _debitCartNumber;
@synthesize parent = _parent;
@synthesize payButton = _payButton;
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

    [_depositSlider setMinimumValue:(_orderCost * 0.1)];
    [_depositSlider setMaximumValue:_orderCost];
    [_depositSlider sendActionsForControlEvents:UIControlEventValueChanged];
    
    _depositLabel.text = [[NSNumber numberWithFloat:floor(_depositSlider.minimumValue)] stringValue];
    
    validCardNumber = NO;
    
    [_payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_payButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self updatePayButtonStatus];
}

- (void)viewDidUnload
{
    [self setDepositSlider:nil];
    [self setDepositLabel:nil];
    [self setDebitCartNumber:nil];
    [self setPayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)updatePayButtonStatus {
    if (validCardNumber) {
        [_payButton setEnabled:YES];
    } else {
        [_payButton setEnabled:NO];
    }
}

- (IBAction)pay:(id)sender {

    ShoppingCart* shoppingCart = [PetDAO shoppingCart];
    [shoppingCart removePets:[shoppingCart pets]];
    
    id<RefreshableViewController> rootViewController = (id<RefreshableViewController>)[[self.navigationController viewControllers] objectAtIndex:0];
    [rootViewController refresh];
    
    [_parent pushViewPaymentDone];
}

- (IBAction)depositAmountChanged:(id)sender {
    _depositLabel.text = [[NSNumber numberWithFloat:floor([_depositSlider value])] stringValue];
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
