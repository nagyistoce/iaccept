//
//  ETPromoDetailViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "ETPromoDetailViewController.h"
#import "Pet.h"
#import "PetDAO.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "ETAppDelegate.h"

@interface ETPromoDetailViewController () {
    UIImageView* currentAnimatedPetPhoto;
}
@property (strong, nonatomic) NSFetchedResultsController* pets;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

-(NSFetchedResultsController*)pets;

@end

@implementation ETPromoDetailViewController
@synthesize promoTable = _promoTable;
@synthesize promoTableCell = _promoCell;
@synthesize petPhotoView = _petPhotoView;
@synthesize tabBar = _tabBar;
@synthesize dogTabBarItem = _dogTabBarItem;
@synthesize catTabBarItem = _catTabBarItem;
@synthesize moreTabBarItem = _moreTabBarItem;
@synthesize pets = _pets;

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
    [_promoTable setRowHeight:255];
    [_promoTable setBackgroundView:nil];
    self.title = @"Manager's Deals Of The Week!";
    
    [_tabBar setSelectedItem:_dogTabBarItem];
}

- (void)viewDidUnload
{
    [self setPromoTable:nil];
    [self setPromoTableCell:nil];
    [self setPetPhotoView:nil];
    [self setTabBar:nil];
    [self setDogTabBarItem:nil];
    [self setCatTabBarItem:nil];
    [self setMoreTabBarItem:nil];
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.pets sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.pets sections] objectAtIndex:section] numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PromoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PromoCell" owner:self options:nil];
        cell = _promoCell;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString* kind = [[[[[self.pets sections] objectAtIndex:section] objects] objectAtIndex:0] kind];
    if ([kind isEqualToString:@"dog"]) {
        return @"Dog(s)";
    } else if ([kind isEqualToString:@"cat"]) {
        return @"Cat(s)";
    } else if ([kind isEqualToString:@"fish"]) {
        return @"Fish(es)";
    } else if ([kind isEqualToString:@"reptile"]) {
        return @"Reptile(s)";
    } else if ([kind isEqualToString:@"bird"]) {
        return @"Bird(s)";
    }
    
    return @"Other";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Pet* pet = [self.pets objectAtIndexPath:indexPath];

    ((UIImageView*)[cell viewWithTag:1]).image = [pet photo];
    ((UILabel*)[cell viewWithTag:2]).text = [pet name];
    ((UILabel*)[cell viewWithTag:3]).text = [pet race];
    ((UILabel*)[cell viewWithTag:4]).text = [[pet price] stringValue];
    ((UILabel*)[cell viewWithTag:5]).text = [[pet specialPrice] stringValue];
    ((UILabel*)[cell viewWithTag:6]).text = [[pet offPercentage] stringValue];

}

-(NSFetchedResultsController*)pets {
    if (_pets) {
        return _pets;
    }
    
    if ([_tabBar selectedItem] == _dogTabBarItem) {
        _pets = [PetDAO dogsInPromotion];
    } else if ([_tabBar selectedItem] == _catTabBarItem) {
        _pets = [PetDAO catsInPromotion]; 
    } else {
       _pets = [PetDAO otherPetsInPromotion]; 
    }
    
    NSError *error = nil;
	if (![_pets performFetch:&error]) {
        
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _pets;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    self.navigationItem.leftBarButtonItem = nil;
    
}

- (void)animateButton:(UIButton *)button {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.125;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [button.layer addAnimation:anim forKey:nil];   
}

- (CGPoint)convertShoppingCartPoint:(UIView *)vc shoppingCartButton:(UIButton *)shoppingCartButton {
    CGPoint convertedShoppingCenter = vc.frame.origin;
    
    if (UIInterfaceOrientationIsLandscape([self interfaceOrientation])) {
        convertedShoppingCenter = [shoppingCartButton.superview convertPoint:shoppingCartButton.center toView:vc];
    }
    return convertedShoppingCenter;
}

- (UIButton *)getShoppingCartButton {
    ETMasterViewController* masterView = [[(UINavigationController*)[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    UIButton* shoppingCartButton = [masterView shoppingCartButton];
    return shoppingCartButton;
}

- (CGPoint)convertPetPhotoPoint:(UIView *)vc photo:(UIImageView *)petPhoto {
    CGPoint center =  petPhoto.frame.origin;
    CGPoint convertedCenter = [petPhoto convertPoint:center toView:vc];
    convertedCenter.x += 100; 
    convertedCenter.y += 100; 
    return convertedCenter;
}

- (UIView *)getRootView {
    UIView *vc =[[[(ETAppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] view];
    return vc;
}

- (void)movePhotoToRootView:(CGPoint)convertedCenter petPhoto:(UIImageView *)petPhoto vc:(UIView *)vc {
    petPhoto.center = convertedCenter;
    [vc addSubview:petPhoto];
    petPhoto.layer.opacity = 0.0;
}

- (void)animateMoveToShoppingCart:(CGPoint)convertedCenter convertedShoppingCenter:(CGPoint)convertedShoppingCenter petPhoto:(UIImageView *)petPhoto {
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:convertedCenter];
    [movePath addQuadCurveToPoint:convertedShoppingCenter controlPoint:CGPointMake(convertedShoppingCenter.x+500, convertedShoppingCenter.y+500)];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnim.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnim.toValue = [NSNumber numberWithFloat:0.3];
    alphaAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.8];
    opacityAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, alphaAnim, nil];
    animGroup.duration = 0.5;
    animGroup.delegate = self;
    animGroup.removedOnCompletion = YES;
    [petPhoto.layer addAnimation:animGroup forKey:@"moveToShoppingCart"];
}

- (void)putPhotoInShoppingCart:(id)cell {
    UIImageView* petPhoto = (UIImageView*)[cell viewWithTag:1];
    currentAnimatedPetPhoto = petPhoto;
    
    UIView *vc = [self getRootView];
    UIButton* shoppingCartButton = [self getShoppingCartButton];

    CGPoint convertedCenter = [self convertPetPhotoPoint:vc photo:petPhoto];
    CGPoint convertedShoppingCenter = [self convertShoppingCartPoint:vc shoppingCartButton:shoppingCartButton];
    
    [self movePhotoToRootView:convertedCenter petPhoto:petPhoto vc:vc];
    [self animateMoveToShoppingCart:convertedCenter convertedShoppingCenter:convertedShoppingCenter petPhoto:petPhoto];
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    if (currentAnimatedPetPhoto) {
        [_promoTable reloadData];
        [currentAnimatedPetPhoto removeFromSuperview];
        currentAnimatedPetPhoto = nil;
    }
}

- (IBAction)buyNowButtonTouch:(id)sender {
    
    UIButton* button = (UIButton*)sender;
    [self animateButton:button];
    id cell = [[button superview] superview];
    
    NSIndexPath* indexPath = [_promoTable indexPathForCell:cell];
    
    Pet* pet = [_pets objectAtIndexPath:indexPath];
    [PetDAO addPetToShoppingCart:pet];
    [self putPhotoInShoppingCart:cell];
    _pets = nil;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    _pets = nil;
    [_promoTable reloadData];
}
@end
