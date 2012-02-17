//
//  ETMasterViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETDetailViewController;

#import <CoreData/CoreData.h>

@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface ETMasterViewController : UITableViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) UIViewController<SubstitutableDetailViewController> *detailViewController;

@property (nonatomic, strong) UISplitViewController *splitViewController;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) UIBarButtonItem *rootPopoverButtonItem;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *shoppingCartButton;
- (IBAction)touchShoppingCartButton:(id)sender;

- (IBAction)disclaimer:(id)sender;
- (IBAction)policy:(id)sender;
- (IBAction)animalWelfare:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *managersDealsButton;
- (IBAction)touchManagersDealsButton:(id)sender;

@end
