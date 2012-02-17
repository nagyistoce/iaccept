//
//  ETMasterViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "ETMasterViewController.h"
#import "ETDetailViewController.h"
#import "ETPromoDetailViewController.h"
#import "ETShoppingCartViewController.h"
#import "PetDAO.h"
#import "ETLegalDisclaimerPageController.h"
#import "ETStorePolicyController.h"
#import "ETAnimalWellfareViewController.h"

@interface ETMasterViewController () {
    int dog;
    int cat;
    int fish;
    int reptile;
    int bird;
}
@property (strong, nonatomic) IBOutlet UITableView *petsTable;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ETMasterViewController
@synthesize managersDealsButton;
@synthesize shoppingCartButton;

@synthesize popoverController, splitViewController, rootPopoverButtonItem;


@synthesize detailViewController = _detailViewController;
@synthesize petsTable = _petsTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Elapse Pet Shop", @"Elapse Pet Shop");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dog= 0;
    cat = 1;
    fish = 2;
    reptile = 3;
    bird = 4;

}

- (void)viewDidUnload
{
    [self setShoppingCartButton:nil];
    [self setManagersDealsButton:nil];
    _petsTable = nil;
    [self setPetsTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)deselectTableView {
    NSIndexPath *tableSelection = [self.petsTable indexPathForSelectedRow];  
    [self.petsTable deselectRowAtIndexPath:tableSelection animated:YES];
}

- (void)substituteDetailView {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.detailViewController];
    navController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],navController,nil];
    self.splitViewController.viewControllers = viewControllers;
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
    
    // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
    if (rootPopoverButtonItem != nil) {
        [self.detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }
}

- (IBAction)touchShoppingCartButton:(id)sender {
    
    [self deselectTableView];
    
    ETShoppingCartViewController* detailView;
    
    if ([_detailViewController isKindOfClass:[ETShoppingCartViewController class]]) {
        detailView = (ETShoppingCartViewController*)_detailViewController;
    } else {
        detailView = [[ETShoppingCartViewController alloc] initWithNibName:@"ETShoppingCartViewController" bundle:nil];
        self.detailViewController = detailView;
    }
    
    [self substituteDetailView];
    
}

- (IBAction)disclaimer:(id)sender {
    ETLegalDisclaimerPageController* detailView = [[ETLegalDisclaimerPageController alloc] init];
    self.detailViewController = detailView;
    
    [self substituteDetailView];
}

- (IBAction)policy:(id)sender {
    ETStorePolicyController* detailView = [[ETStorePolicyController alloc] init];
    self.detailViewController = detailView;
    
    [self substituteDetailView];
}

- (IBAction)animalWelfare:(id)sender {
    
    ETAnimalWellfareViewController* detailView = [[ETAnimalWellfareViewController alloc] init];
    self.detailViewController = detailView;
    
    [self substituteDetailView];
}

- (IBAction)touchManagersDealsButton:(id)sender {
    
    [self deselectTableView];
    
    ETPromoDetailViewController* detailView;
    
    if ([_detailViewController isKindOfClass:[ETPromoDetailViewController class]]) {
        detailView = (ETPromoDetailViewController*)_detailViewController;
    } else {
        detailView = [[ETPromoDetailViewController alloc] initWithNibName:@"ETPromoDetailViewController" bundle:nil];
        self.detailViewController = detailView;
    }
    
    [self substituteDetailView];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int dogSection = 1;
    int catSection = 1;
    int fishSection = 1;
    int reptileSection = 1;
    int birdSection = 1;
    
    return dogSection + catSection + fishSection + reptileSection + birdSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* kind;
    if ([indexPath section] == dog) {
        kind = @"dog";
    } else if ([indexPath section] == cat) {
        kind = @"cat";
    } else if ([indexPath section] == fish) {
        kind = @"fish";
    } else if ([indexPath section] == reptile) {
        kind = @"reptile";
    } else if ([indexPath section] == bird) {
        kind = @"bird";
    }

    ETDetailViewController* detailView;
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([_detailViewController isKindOfClass:[ETDetailViewController class]]) {
        detailView = (ETDetailViewController*)_detailViewController;
    } else {
        detailView = [[ETDetailViewController alloc] initWithNibName:@"ETDetailViewController" bundle:nil];
        self.detailViewController = detailView;
    }
    
    [detailView setPetKind:kind withTitle:cell.textLabel.text andPetImage:cell.imageView.image];
    
    [self substituteDetailView];

}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UIImage* kindImage = [UIImage imageNamed:@""];
    NSString* kindName;
    
    if ([indexPath section] == dog) {
        kindImage = [UIImage imageNamed:@"dog-icon.png"];
        kindName = @"Dogs";
    } else if ([indexPath section] == cat) {
        kindImage = [UIImage imageNamed:@"cat-icon.png"];
        kindName = @"Cats";
    } else if ([indexPath section] == fish) {
        kindImage = [UIImage imageNamed:@"fish-icon.png"];
        kindName = @"Fishes";
    } else if ([indexPath section] == reptile) {
        kindImage = [UIImage imageNamed:@"snake-icon.png"];
        kindName = @"Reptiles";
    } else if ([indexPath section] == bird) {
        kindImage = [UIImage imageNamed:@"bird-icon.png"];
        kindName = @"Birds";
    }
    
    cell.imageView.image = kindImage;
    cell.textLabel.text = kindName;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Shop";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    //    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    //    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [self.detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}


@end
