//
//  ETDetailViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "ETDetailViewController.h"
#import "PetDAO.h"


@interface ETDetailViewController ()
@property (strong, nonatomic) NSFetchedResultsController* pets;
@property (strong, nonatomic) IBOutlet UITableViewCell *petCell;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dollarPriceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *priceNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *offLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *offNameLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dollarSpecialLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *specialNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *specialStarImage;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureView;
-(NSFetchedResultsController*)pets;

@end

@implementation ETDetailViewController

@synthesize petCell = _petCell;
@synthesize dollarPriceLabel = _dollarPriceLabel;
@synthesize priceNameLabel = _priceNameLabel;
@synthesize offLabel = _offLabel;
@synthesize offNameLabel = _offNameLabel;
@synthesize dollarSpecialLabel = _dollarSpecialLabel;
@synthesize specialNameLabel = _specialNameLabel;
@synthesize specialStarImage = _specialStarImage;

@synthesize petKind = _petKind;
@synthesize petImage = _petImage;
@synthesize petTitle = _petTitle;
@synthesize addToCartButton = _addToCartButton;


@synthesize petKindImage = _petKindImage;
@synthesize petKindLabel = _petKindLabel;
@synthesize petTable = _petTable;
@synthesize petPhotoImage = _petPhotoImage;
@synthesize breedLabel = _breedLabel;
@synthesize nameLabel = _nameLabel;
@synthesize colorLabel = _colorLabel;
@synthesize bornLabel = _bornLabel;
@synthesize ageLabel = _ageLabel;
@synthesize priceLabel = _priceLabel;
@synthesize specialPriceLabel = _specialPriceLabel;
@synthesize pets = _pets;



#pragma mark - Managing the detail item

- (IBAction)addToCartButtonTouch:(id)sender {
    NSIndexPath* indexPath = [_petTable indexPathForSelectedRow];
    
    Pet* pet = [_pets objectAtIndexPath:indexPath];
    [PetDAO addPetToShoppingCart:pet];
    _pets = nil;
    
    [_petTable reloadData];
    [self configureView];
}

- (void)setPetKind:(NSString*)petKind withTitle:(NSString*)title andPetImage:(UIImage*)image 
{
    if (_petKind != petKind) {
        _petKind = petKind;
        _petImage = image;
        _petTitle = title;

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.petKind) {
        _petKindImage.image = _petImage;
        _petKindLabel.text = _petTitle;
        _petPhotoImage.image = _petImage;
        
        self.title = NSLocalizedString(_petTitle, _petTitle);
        
        _breedLabel.text = @"";
        _nameLabel.text = @"";
        _colorLabel.text = @"";
        _bornLabel.text = @"";
        _ageLabel.text = @"";
        _priceLabel.text = @"";
        
        [_dollarSpecialLabel setHidden:YES];
        [_specialNameLabel setHidden:YES];
        [_specialPriceLabel setHidden:YES];
        [_specialStarImage setHidden:YES];
        [_offLabel setHidden:YES];
        [_offNameLabel setHidden:YES];
        
        _priceLabel.textColor = [UIColor blackColor];
        _dollarPriceLabel.textColor = [UIColor blackColor];
        _priceNameLabel.textColor = [UIColor blackColor];
        
        [_addToCartButton setEnabled:NO];
        _pets = nil;
        _pets = [self pets];
        [_petTable reloadData];
    }

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
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)viewDidUnload
{
    [self setPetTable:nil];
    [self setPetKindLabel:nil];
    [self setPetKindImage:nil];
    [self setPetPhotoImage:nil];
    [self setBreedLabel:nil];
    [self setNameLabel:nil];
    [self setColorLabel:nil];
    [self setBornLabel:nil];
    [self setAgeLabel:nil];
    [self setPriceLabel:nil];
    [self setSpecialPriceLabel:nil];
    [self setPetCell:nil];
    [self setDollarSpecialLabel:nil];
    [self setSpecialNameLabel:nil];
    [self setSpecialStarImage:nil];
    [self setDollarPriceLabel:nil];
    [self setPriceNameLabel:nil];
    [self setOffLabel:nil];
    [self setOffNameLabel:nil];
    [self setAddToCartButton:nil];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int no = 0;
    
    if ([[self.pets sections] count] > 0) {
        no = [[[self.pets sections] objectAtIndex:section] numberOfObjects];
    }
    return no;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PetCell" owner:self options:nil];
        cell = _petCell;
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSDateFormatter *)formatterForDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale* caLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_CA"];
    [dateFormatter setLocale:caLocale];
    return dateFormatter;
}

- (void)setupViewData:(Pet *)pet
{
    [_addToCartButton setEnabled:YES];
    _petPhotoImage.image = [pet photo];
    _breedLabel.text = [pet race];
    _nameLabel.text = [pet name];
    _colorLabel.text = [pet color];
    
    NSDateFormatter *dateFormatter = [self formatterForDate];
    
    NSString* date = [dateFormatter stringFromDate:[pet birth]];
    _bornLabel.text = date;
    
    _ageLabel.text = [pet age];
    _priceLabel.text = [[pet price] stringValue];
    _specialPriceLabel.text = [[pet specialPrice] stringValue];
}

- (void)setupIsSpecialViewsData:(Pet *)pet
{
 
    [_dollarSpecialLabel setHidden:NO];
    [_specialNameLabel setHidden:NO];
    [_specialPriceLabel setHidden:NO];
    [_specialStarImage setHidden:NO];
    [_offLabel setHidden:NO];
    [_offNameLabel setHidden:NO];
    
    _offLabel.text = [[pet offPercentage] stringValue];
    
    _priceLabel.textColor = [UIColor lightGrayColor];
    _dollarPriceLabel.textColor = [UIColor lightGrayColor];
    _priceNameLabel.textColor = [UIColor lightGrayColor];
}

- (void)setupIsNotSpecialViewsData
{
    [_dollarSpecialLabel setHidden:YES];
    [_specialNameLabel setHidden:YES];
    [_specialPriceLabel setHidden:YES];
    [_specialStarImage setHidden:YES];
    [_offLabel setHidden:YES];
    [_offNameLabel setHidden:YES];
    
    _priceLabel.textColor = [UIColor blackColor];
    _dollarPriceLabel.textColor = [UIColor blackColor];
    _priceNameLabel.textColor = [UIColor blackColor];
}

- (void)setupSpecialPriceViewsData:(Pet *)pet
{
    if (![[pet specialPrice] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [self setupIsSpecialViewsData:pet];
    } else {
        [self setupIsNotSpecialViewsData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.pets sections] objectAtIndex:[indexPath section]];
    Pet* pet  = [[sectionInfo objects] objectAtIndex:[indexPath row]];
    
    [self setupViewData:pet];
    [self setupSpecialPriceViewsData:pet];

}

- (void)specialPriceCell:(UITableViewCell *)cell pet:(Pet *)pet
{
    ((UILabel*)[cell viewWithTag:3]).textColor = [UIColor lightGrayColor];
    ((UILabel*)[cell viewWithTag:8]).textColor = [UIColor lightGrayColor];
    
    ((UILabel*)[cell viewWithTag:4]).text = [[pet specialPrice] stringValue];
    ((UILabel*)[cell viewWithTag:4]).textColor = [UIColor redColor];
    ((UILabel*)[cell viewWithTag:4]).shadowColor = [UIColor blackColor];
    ((UILabel*)[cell viewWithTag:4]).shadowOffset = CGSizeMake(1, 1);
    
    ((UILabel*)[cell viewWithTag:5]).text = @"$";
    
    [[cell viewWithTag:4] setHidden:NO];
    [[cell viewWithTag:5] setHidden:NO];
    
    [[cell viewWithTag:6] setHidden:NO];
    [[cell viewWithTag:7] setHidden:NO];
}

- (void)regularPriceCell:(UITableViewCell *)cell
{
    ((UILabel*)[cell viewWithTag:5]).text = @"";
    ((UILabel*)[cell viewWithTag:3]).textColor = [UIColor blackColor];
    ((UILabel*)[cell viewWithTag:8]).textColor = [UIColor blackColor];
    
    [[cell viewWithTag:4] setHidden:YES];
    [[cell viewWithTag:5] setHidden:YES];
    
    [[cell viewWithTag:6] setHidden:YES];
    [[cell viewWithTag:7] setHidden:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.pets sections] objectAtIndex:[indexPath section]];
    Pet* pet  = [[sectionInfo objects] objectAtIndex:[indexPath row]];
    
    ((UIImageView*)[cell viewWithTag:11]).image = [pet photo];
    ((UILabel*)[cell viewWithTag:1]).text = [pet name];
    ((UILabel*)[cell viewWithTag:2]).text = [pet race];
    ((UILabel*)[cell viewWithTag:3]).text = [[pet price] stringValue];
    
    if (![[pet specialPrice] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [self specialPriceCell:cell pet:pet];
    } else {
        [self regularPriceCell:cell];
    }
}

-(NSFetchedResultsController*)pets {
    if (_pets || _petKind == nil) {
        return _pets;
    }
    self.pets = [PetDAO petsOfKind:_petKind];
    
    NSError *error = nil;
	if (![self.pets performFetch:&error]) {

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

@end
