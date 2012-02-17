//
//  ETAppDelegate.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UISplitViewController *splitViewController;

-(void)emptyShoppingCart;
-(void)putPetsInShoppingCart;
@end
