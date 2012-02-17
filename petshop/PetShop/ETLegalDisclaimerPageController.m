//
//  ETLegalDisclaimerViewController.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-02.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ETLegalDisclaimerPageController.h"
#import "ETLegalDisclaimerPage1ViewController.h"
#import "ETLegalDisclaimerPage2ViewController.h"
#import "ETLegalDisclaimerPage3ViewController.h"

@interface ETLegalDisclaimerPageController() {
    NSMutableArray* pages;
}

@property(strong, nonatomic) UIPageViewController *pageController;

-(NSUInteger)indexOfViewController:(UIViewController *)viewController;
-(UIViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

@implementation ETLegalDisclaimerPageController

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
    
    self.title = @"Legal Disclaimer (3 pages)";
    // Do any additional setup after loading the view from its nib.
    
    pages = [[NSMutableArray alloc] init];

    ETLegalDisclaimerPage1ViewController* page1 = [[ETLegalDisclaimerPage1ViewController alloc] initWithNibName:@"ETLegalDisclaimerPage1ViewController" bundle:nil];
    ETLegalDisclaimerPage2ViewController* page2 = [[ETLegalDisclaimerPage2ViewController alloc] initWithNibName:@"ETLegalDisclaimerPage2ViewController" bundle:nil];
    ETLegalDisclaimerPage3ViewController* page3 = [[ETLegalDisclaimerPage3ViewController alloc] initWithNibName:@"ETLegalDisclaimerPage3ViewController" bundle:nil];

    [pages addObject:page1];
    [pages addObject:page2];
    [pages addObject:page3];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    _pageController.dataSource = self;
    [[_pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [NSArray arrayWithObject:[self viewControllerAtIndex:0]];
    
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

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    self.navigationItem.leftBarButtonItem = nil;
    
}

@end
