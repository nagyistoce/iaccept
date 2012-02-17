//
//  PetShopFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//


#import "PetShopFixture.h"

#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import <Framework-iAccept/IADeviceOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>

#import "ETAppDelegate.h"


@interface PetShopFixture() {
    
}
@end

@implementation PetShopFixture

-(void)resetMenuSelection {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IATableOperator* tableOperator = [IATableOperator tableOperatorForUITableView:(UITableView*)[[splitOperator masterViewOperator] uiView]];
    
    [tableOperator unselect];
}

-(void)resetMainViewToPromotions {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* promoButton = [masterViewOperator searchForButtonWithImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [promoButton touch]; 
}

-(void) iLaunchedThePetshopInLandscape {
    [IADeviceOperator forceLandscapeOrientation];
    [self resetMenuSelection];
    [self resetMainViewToPromotions];
}

-(void) iLaunchedThePetshopInPortrait {
    [IADeviceOperator forcePortraitOrientation];
    [self resetMenuSelection];
    [self resetMainViewToPromotions];
}

-(void) iTouchTheShopButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IANavigationBarOperator* navBar = [IANavigationBarOperator navigationBarOperatorForUINavigationBar:(UINavigationBar*)[[detailViewOperator searchForViewOfClass:[UINavigationBar class]] uiView]];
    [navBar touchLeftBarButton];
}

-(void)iStartWithAnEmptyShoppingCart {
    ETAppDelegate*  appDeletage = [self appDelegate];
    [appDeletage emptyShoppingCart];
}

-(void)iStartWithPetsInShoppingCart {
    ETAppDelegate*  appDeletage = [self appDelegate];
    [appDeletage putPetsInShoppingCart];
}

@end