//
//  ETShoppingCartViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-12-20.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETMasterViewController.h"
#import "ShoppingCart.h"
#import "RefreshableViewController.h"

@interface ETShoppingCartViewController : UIViewController <SubstitutableDetailViewController, RefreshableViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

- (IBAction)deleteButtonTouch:(id)sender;
- (IBAction)deleteToogle:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *shoppingCartTable;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *deleteButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;

- (IBAction)pay:(id)sender;



@end
