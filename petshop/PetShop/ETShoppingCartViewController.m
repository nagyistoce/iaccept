//
//  ETShoppingCartViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-12-20.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "ETShoppingCartViewController.h"
#import "PetDAO.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "ETCreditCardPaymentViewController.h"
#import "ETPaymentViewController.h"

@interface ETShoppingCartViewController () {
    NSMutableSet* itemsToDelete;
}
@property (strong, nonatomic) ShoppingCart* shoppingCart;

- (void)configureCell:(UITableViewCell *)cell atRow:(int)row;

@property (strong, nonatomic) IBOutlet UITableViewCell *cartCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *cartHeaderCell;

-(ShoppingCart*)shoppingCart;
-(void)updateCheckoutButtonStatus;

@end

@implementation ETShoppingCartViewController
@synthesize deleteButton = _deleteButton;
@synthesize totalLabel = _totalLabel;
@synthesize checkoutButton = _checkoutButton;

@synthesize shoppingCartTable = _shoppingCartTable;
@synthesize cartCell = _cartCell;
@synthesize cartHeaderCell = _cartHeaderCell;
@synthesize shoppingCart = _shoppingCart;



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

- (int)computeShoppingCartTotalCost
{
    int total = 0;
    for (Pet* pet in [_shoppingCart pets]) {
        if (![[pet specialPrice] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            total += [[pet specialPrice] intValue];
        } else {
            total += [[pet price] intValue];
        }
    }
    return total;
}

- (void)computeTotal
{
    int total = [self computeShoppingCartTotalCost];
    _totalLabel.text = [NSString stringWithFormat:@"%d", total];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Shopping Cart";
    itemsToDelete = [[NSMutableSet alloc] init];
    
    [_checkoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkoutButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self updateCheckoutButtonStatus];
}

- (void)viewDidUnload
{

    [self setCartCell:nil];
    [self setCartHeaderCell:nil];
    [self setShoppingCartTable:nil];
    [self setDeleteButton:nil];
    [self setTotalLabel:nil];
    [self setCheckoutButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)updateCheckoutButtonStatus {
    int count = [[self.shoppingCart pets] count];
    if (count > 0) {
        [_checkoutButton setEnabled:YES];
    } else {
        [_checkoutButton setEnabled:NO];
    }
}

- (void)glowTrashCan {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    anim.fromValue = [NSNumber numberWithFloat:0.0];
    anim.toValue = [NSNumber numberWithFloat:1.0];
    anim.autoreverses=YES;
    anim.duration = 1.0;
    anim.repeatCount = 10;
    
    [_deleteButton.layer addAnimation:anim forKey:@"shadowOpacity"];
    _deleteButton.layer.shadowOpacity = 0.0f;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int header = 1;
    int petCount =  [[self.shoppingCart pets] count];
    return header + petCount;
}

- (UITableViewCell*)createHeaderRow:(UITableView *)tableView
{
    static NSString *CellIdentifier = @"CartHeaderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CartHeaderCell" owner:self options:nil];
        cell = _cartHeaderCell;
        _deleteButton = (UIButton*)[_cartHeaderCell viewWithTag:1];
        _deleteButton.layer.shadowColor = [UIColor brownColor].CGColor;
        _deleteButton.layer.shadowOpacity = 0.0;
        _deleteButton.layer.shadowRadius = 10;
    }
    
    if ([itemsToDelete count] != 0) {
        [self glowTrashCan];
    }
    return cell;
}

- (UITableViewCell*)createCartItemRow:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    int row = [indexPath row] - 1;
    
    static NSString *CellIdentifier = @"CartCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CartCell" owner:self options:nil];
        cell = _cartCell;
    }
    
    [self configureCell:cell atRow:row];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return [self createHeaderRow:tableView];
    } else {
        return [self createCartItemRow:indexPath tableView:tableView];
    }
}

- (Pet *)petAtRow:(int)row {
    NSSortDescriptor * sortKey = [[NSSortDescriptor alloc] initWithKey:@"kind" ascending:YES];
    NSArray * descriptors =[NSArray arrayWithObjects:sortKey, nil];
    Pet* pet = [[[_shoppingCart pets] sortedArrayUsingDescriptors:descriptors] objectAtIndex:row];
    return pet;
}

- (void)configureCell:(UITableViewCell *)cell atRow:(int)row {
    Pet* pet = [self petAtRow:row];
    
    if ([itemsToDelete containsObject:pet]) {
        [((UISwitch*)[cell viewWithTag:1]) setOn:YES];
    }
    
    ((UIImageView*)[cell viewWithTag:2]).image = [pet photo];
    ((UITextView*)[cell viewWithTag:3]).text = [pet race]; 
    
    if (![[pet specialPrice] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        ((UITextView*)[cell viewWithTag:4]).text = [[pet specialPrice] stringValue];
    } else {
        ((UITextView*)[cell viewWithTag:4]).text = [[pet price] stringValue];
    }
}

-(ShoppingCart*)shoppingCart {
    if (_shoppingCart) {
        return _shoppingCart;
    }
    _shoppingCart = [PetDAO shoppingCart];
    [self computeTotal];
    return _shoppingCart;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)stopGlowTrashCan {
    if ([itemsToDelete count] == 0) {
        [_deleteButton.layer removeAnimationForKey:@"shadowOpacity"];
    }
}

-(void)refresh {
    [_shoppingCartTable reloadData];
    [self updateCheckoutButtonStatus];
    [self computeTotal];
    
}

- (IBAction)deleteButtonTouch:(id)sender {
    for (Pet* pet in itemsToDelete) {
        [PetDAO removePetFromChoppingCart:pet];
    }
    
    [itemsToDelete removeAllObjects];
    [self stopGlowTrashCan];
    [self computeTotal];
    [_shoppingCartTable reloadData];
    
    [self updateCheckoutButtonStatus];
}

- (IBAction)deleteToogle:(id)sender {
    
    UISwitch* swtch = (UISwitch*)sender;
    id cell = [[swtch superview] superview];
    NSIndexPath* indexPath = [_shoppingCartTable indexPathForCell:cell];
    
    Pet* pet = [self petAtRow:[indexPath row]-1];
    
    if ([swtch isOn]) {
        [self glowTrashCan];
        [itemsToDelete addObject:pet];
    } else {
        [itemsToDelete removeObject:pet];
        [self stopGlowTrashCan];
    }
}

- (IBAction)pay:(id)sender {
    ETPaymentViewController *paymentController = [[ETPaymentViewController alloc] initWithOrderCost:[self computeShoppingCartTotalCost]];
    [[self navigationController] pushViewController:paymentController animated:YES];
}



@end
