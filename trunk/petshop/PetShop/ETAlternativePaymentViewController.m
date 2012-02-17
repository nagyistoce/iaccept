//
//  ETAlternativePaymentViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETAlternativePaymentViewController.h"
#import "PetDAO.h"
#import "ShoppingCart.h"
#import "RefreshableViewController.h"
#import "Util.h"


@implementation ETAlternativePaymentViewController

@synthesize paymentType = _paymentType;
@synthesize paymentMode = _paymentMode;
@synthesize orderCost = _orderCost;
@synthesize url = _url;
@synthesize parent = _parent;
@synthesize depositStepper = _depositStepper;
@synthesize activity = _activity;
@synthesize informationButton = _informationButton;
@synthesize onlineInStoreChoice = _onlineInStoreChoice;
@synthesize paymentTypeLabel = _paymentTypeLabel;
@synthesize depositAmount = _depositAmount;
@synthesize webView = _webView;

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
    // Do any additional setup after loading the view from its nib.
    
    _paymentMode = 0;
    [_onlineInStoreChoice setSelectedSegmentIndex:_paymentMode];
    
    [_depositStepper setMinimumValue:(_orderCost * 0.1)];
    [_depositStepper setMaximumValue:_orderCost];
    [_depositStepper setStepValue:50];
    [_depositStepper sendActionsForControlEvents:UIControlEventValueChanged];
    
    _depositAmount.text = [[NSNumber numberWithFloat:floor(_depositStepper.minimumValue)] stringValue];
    
    _paymentTypeLabel.text = _paymentType;
    
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:urlRequest];
    
    [_informationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_informationButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

- (void)viewDidUnload
{
    [self setPaymentTypeLabel:nil];
    [self setDepositAmount:nil];
    [self setWebView:nil];
    [self setDepositStepper:nil];
    [self setActivity:nil];
    [self setInformationButton:nil];
    [self setOnlineInStoreChoice:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)stepValueChanged:(id)sender {
    _depositAmount.text = [[NSNumber numberWithFloat:floor([_depositStepper value])] stringValue];
}

- (IBAction)tooglePaymentMode:(id)sender {
    _paymentMode = [_onlineInStoreChoice selectedSegmentIndex];
}

- (IBAction)information:(id)sender {
    ShoppingCart* shoppingCart = [PetDAO shoppingCart];
    [shoppingCart removePets:[shoppingCart pets]];
    
    id rootViewController = [[_parent.navigationController viewControllers] objectAtIndex:0];
    if ([rootViewController conformsToProtocol:@protocol(RefreshableViewController)]) {
        [rootViewController refresh];
    } 
    
    [_parent pushViewPaymentDone];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activity stopAnimating];  
    [_informationButton setEnabled:YES];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {     
    [_activity startAnimating];  
    [_informationButton setEnabled:NO];
}
@end
