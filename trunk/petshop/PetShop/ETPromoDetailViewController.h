//
//  ETPromoDetailViewController.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-21.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETMasterViewController.h"

@interface ETPromoDetailViewController : UIViewController <SubstitutableDetailViewController, UITabBarDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *promoTable;
@property (strong, nonatomic) IBOutlet UITableViewCell *promoTableCell;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *petPhotoView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *dogTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *catTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *moreTabBarItem;

- (IBAction)buyNowButtonTouch:(id)sender;

@end
