//
//  ETPaymentViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-30.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETPaymentViewController.h"
#import "ETCreditCardPaymentViewController.h"
#import "ETDebitCardPaymentViewController.h"
#import "ETShoppingCartViewController.h"
#import "ETPaymentDoneViewController.h"
#import "ETAlternativePaymentViewController.h"

@interface ETPaymentViewController() {
    NSArray *tabBarViews;
}

@end

@implementation ETPaymentViewController

@synthesize orderCost = _orderCost;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithOrderCost:(int)orderCost {
    _orderCost = orderCost;
    self = [super init];
    if(self) {
        
        
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

    NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
    
    ETDebitCardPaymentViewController* debitController = [[ETDebitCardPaymentViewController alloc] initWithNibName:@"ETDebitCardPaymentViewController" bundle:nil];
    debitController.title = @"Debit";
    [debitController setOrderCost:_orderCost];
    [debitController setParent:self];
    debitController.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    [controllerArray addObject:debitController];
    
    ETCreditCardPaymentViewController *creditController = [[ETCreditCardPaymentViewController alloc] initWithNibName:@"ETCreditCardPaymentViewController" bundle:nil];
    [creditController setOrderCost:_orderCost];
    [creditController setParent:self];
    creditController.tabBarItem.image = [UIImage imageNamed:@"cc.png"];
    creditController.title = @"Credit";
    [controllerArray addObject:creditController];
    
    ETAlternativePaymentViewController* altElectronicBillPayment = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altElectronicBillPayment setOrderCost:_orderCost];
    [altElectronicBillPayment setParent:self];
    altElectronicBillPayment.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altElectronicBillPayment.title = @"Electronic Bill Payment";
    altElectronicBillPayment.paymentType = @"Electronic Bill Payment";
    [altElectronicBillPayment setUrl:@"http://www.elapsetech.com"];
    [controllerArray addObject:altElectronicBillPayment];
    
    ETAlternativePaymentViewController* altInteracOnline = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altInteracOnline setOrderCost:_orderCost];
    [altInteracOnline setParent:self];
    altInteracOnline.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altInteracOnline.title = @"Interac© Online";
    altInteracOnline.paymentType = @"Interac© Online";
    [altInteracOnline setUrl:@"http://www.interac.ca"];
    [controllerArray addObject:altInteracOnline];
    
    ETAlternativePaymentViewController* altPayPal = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altPayPal setOrderCost:_orderCost];
    [altPayPal setParent:self];
    altPayPal.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altPayPal.title = @"PayPal";
    altPayPal.paymentType = @"PayPal";
    [altPayPal setUrl:@"http://www.paypal.com"];
    [controllerArray addObject:altPayPal];
    
    ETAlternativePaymentViewController* altBankDraft = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altBankDraft setOrderCost:_orderCost];
    [altBankDraft setParent:self];
    altBankDraft.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altBankDraft.title = @"Bank Draft";
    altBankDraft.paymentType = @"Bank Draft";
    [altBankDraft setUrl:@"http://www.nbc.ca"];
    [controllerArray addObject:altBankDraft];
    
    ETAlternativePaymentViewController* altMoneyOrder = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altMoneyOrder setOrderCost:_orderCost];
    [altMoneyOrder setParent:self];
    altMoneyOrder.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altMoneyOrder.title = @"Money Order";
    altMoneyOrder.paymentType = @"Money Order";
    [altMoneyOrder setUrl:@"http://www.westernunion.ca"];
    [controllerArray addObject:altMoneyOrder];
    
    ETAlternativePaymentViewController* altCorporateCreditAccount = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altCorporateCreditAccount setOrderCost:_orderCost];
    [altCorporateCreditAccount setParent:self];
    altCorporateCreditAccount.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altCorporateCreditAccount.title = @"Corporate Credit Account";
    altCorporateCreditAccount.paymentType = @"Corporate Credit Account";
    [altCorporateCreditAccount setUrl:@"http://www.nbc.ca"];
    [controllerArray addObject:altCorporateCreditAccount];
    
    ETAlternativePaymentViewController* altCreditNote = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altCreditNote setOrderCost:_orderCost];
    [altCreditNote setParent:self];
    altCreditNote.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altCreditNote.title = @"Credit Note";
    altCreditNote.paymentType = @"Credit Note";
    [altCreditNote setUrl:@"http://www.elapsetech.com"];
    [controllerArray addObject:altCreditNote];
    
    ETAlternativePaymentViewController* altGiftCard = [[ETAlternativePaymentViewController alloc] initWithNibName:@"ETAlternativePaymentViewController" bundle:nil];
    [altGiftCard setOrderCost:_orderCost];
    [altGiftCard setParent:self];
    altGiftCard.tabBarItem.image = [UIImage imageNamed:@"pig.png"];
    altGiftCard.title = @"Gift Card";
    altGiftCard.paymentType = @"Gift Card";
    [altGiftCard setUrl:@"http://www.elapsetech.com"];
    [controllerArray addObject:altGiftCard];

    self.viewControllers = controllerArray;
    self.moreNavigationController.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    self.customizableViewControllers = controllerArray;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)pushViewPaymentDone {
    ETPaymentDoneViewController* doneView = [[ETPaymentDoneViewController alloc] initWithNibName:@"ETPaymentDoneViewController" bundle:nil];
    UINavigationController* nav = [self navigationController];
    [nav pushViewController:doneView animated:YES];
}

-(void)popView {
    UINavigationController* nav = [self navigationController];
    [nav popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UINavigationBar *morenavbar = navigationController.navigationBar;
    UINavigationItem *morenavitem = morenavbar.topItem;
    /* We don't need Edit button in More screen. */
    morenavitem.rightBarButtonItem = nil;
}

@end
