//
//  ETStorePolicyController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETStorePolicyController.h"
#import "ETStorePolicyPageController.h"


@interface ETStorePolicyController() {
    NSMutableArray* pages;
}

@property(strong, nonatomic) UIPageViewController *pageController;

-(NSUInteger)indexOfViewController:(UIViewController *)viewController;
-(UIViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

@implementation ETStorePolicyController

@synthesize pageController = _pageController;


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
    
    self.title = @"Store Policies";
    // Do any additional setup after loading the view from its nib.
    
    pages = [[NSMutableArray alloc] init];
    
    ETStorePolicyPageController* page1 = [[ETStorePolicyPageController alloc] initWithNibName:@"ETStorePolicyPageController" bundle:nil];
    [page1 setText:@"Policy 1 : \r\n \r\n Return Policies at Open Studio Events. If you are hosting an Open Studio event is it likely that you anticipate retail purchases. With this in mind it is essential that you prepare a Return Policy BEFORE the Open Studio. Read the previous blog titled: Deciding your Return Policies for Retail Purchase to find a list of possible issues that you may want to consider when writing your Return Policy. Post your Return Policy in a visible location in the Studio. (If you do not post your  Return Policy it will be assumed that you have no restrictions on returns which is probably not the case.) This should be at the location where you are most likely to make a transaction such as your sales counter, cash register or packing area. It would be a good idea to post an additional sign in another visible location. Posting your Return Policy signs prevents returns not consistent with the established  return policy. In addition, informing the customers in advance might make them more comfortable knowing your Return Policy before they decide to purchase an item. Take a photo of your Return Policy signs. Save the photos of your Return Policy in case you need to prove your Return Policy was posted.   You can also use these photos for handy reference next time you host an Open Studio. It will help you remember all the things you need to get ready. Prepare your invoices in advance with your Return Policy on the invoice. This can either be on the invoice in your computer, (ready to fill out with the customers name and the items purchased) or have a pre-printed invoice book ready. Print, stamp or use a sticker label  of your Return Policy on the pre-printed Invoice book or sales receipt. Do you have a way that you handle your Return Policy at Open Studio events that you would like to share with other artists and craftspeople? Please feel welcome to share your ideas in the comments."];
    ETStorePolicyPageController* page2 = [[ETStorePolicyPageController alloc] initWithNibName:@"ETStorePolicyPageController" bundle:nil];
    [page2 setText:@"Policy 2 : \r\n \r\nFree Shipping Will you offer free shipping? In your country or internationally? If you aren’t ready to offer free shipping yet, do a quick check and see what your competition is doing. For your customers, free shipping may offer simplicity and a significant perceived benefit. If you research this topic (see further reading below) you may find evidence that persuades you. Or seeing successful competitors offering free shipping might do the trick. But for you, free shipping may mean hard work. Hard work to figure out how to price your products and manage all the possible permutations. Free shipping can remove a potential barrier to a sale. If you want to read more about why free shipping is an important topic for online merchants to understand, you can check out this excellent post by digital alex or read the Free Shipping eBook (which is mentioned by digital alex). Otherwise, if you need to set shipping rates based on off-the-shelf options, read on. Shipping Costs If you are going to charge a fee for shipping, there are a number of off-the-shelf techniques you can use to automate calculation of shipping costs when a customer is checking out. If you come up with your own shipping rate calculations, you may need to pay for custom programming to implement it. Your off-the-shelf options for setting up shipping rate calculations vary depending on how you have implemented eCommerce. The following sections relate to the Method 1/2/3 as described on the OM4 eCommerce setup article."];
    ETStorePolicyPageController* page3 = [[ETStorePolicyPageController alloc] initWithNibName:@"ETStorePolicyPageController" bundle:nil];
    [page3 setText:@"Policy 3 : \r\n \r\nCopy sells.  Beautiful pictures, excellent navigation and the smoothest checkout in the world are great, but you still need words to close the sale.Sadly, the humble words often go neglected in favor of flashier website elements.  Take a fresh look at your ecommerce copy and use these tips to punch it up.Now 100% Jargon Free! – Cut the jargon.  Unless you’re selling to a technical audience, you could be confusing people and losing sales.  Take the reading level down a notch and use simpler words.     Highlight Benefits and Features – This is a direct marketing classic.  Sell the benefit–why prospects should need and want this product from you.  Features have a place too, but don’t skimp on the benefits.     Make it Professional - Typos and bad grammar whittle away your credibility.  They cause your audience to stumble.  Give your site a once over to catch this speed bumps     Ask For The Sale – A “Buy Now” or “Add to Cart” button isn’t the only way to ask for the sale.  If you’re page goes below the fold, you may want to include other links to purchase."];
    ETStorePolicyPageController* page4 = [[ETStorePolicyPageController alloc] initWithNibName:@"ETStorePolicyPageController" bundle:nil];
    [page4 setText:@"Policy 4 : \r\n \r\nMuch is made of funnel analysis for your shopping cart–examining how many people abandon at each step before order confirmation.  Some of this fallout is a natural byproduct of how people use a cart (to “bookmark” items, for example).  The rest is money you’re leaving on the table.Many seemingly well intentioned marketing ideas get baked into the shopping cart only to trip up prospects and hinder sales.  None is more poisonous that the dreaded registration page.The likely rationale is that you want people to register so you can continue to communicate with them.  You might also think that you’re helping them out by gathering their data once so they never have to type it again.WrongThere’s a fundamental tenant of online marketing that applies especially to shopping carts: Ask for the minimum amount of information you need to complete the sale.*You can always get more information later.  If someone abandons your site because they think your registration is too much work too soon, they’re gone forever.My first tip for more profitable ecommerce is to remove registration as a requirement for purchase.  Don’t believe me?  Test it and tell me what you found.Instead, when visitors touch “Checkout” bring them right to the first step in the shopping cart (typically shipping info).Now, you still want to make it easy for repeat customers to login.  In addition to automatically logging them in when they return, you should also present a simple option at the top of the first page in checkout. This can be a simple text or graphical link that reads “Already registered?  touch here to login.”  It should be obvious, but not intrusive.  Don’t distract from getting people to purchase."];
    
    [pages addObject:page1];
    [pages addObject:page2];
    [pages addObject:page3];
    [pages addObject:page4];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    _pageController.dataSource = self;
    _pageController.doubleSided = YES;
    [[_pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:[self viewControllerAtIndex:0], [self viewControllerAtIndex:1], nil];
    
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
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

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([pages count] == 0) || (index >= [pages count])) {
        return nil;
    }
    
    return [pages objectAtIndex:index];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    return [pages indexOfObject:viewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [pages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return UIPageViewControllerSpineLocationMid;
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
