//
//  ShoppingCartFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ShoppingCartFixture.h"
#import "ETAppDelegate.h"
#import "ETDetailViewController.h"
#import "ETShoppingCartViewController.h"
#import "Pet.h"

#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import <Framework-iAccept/IASwitchOperator.h>
#import <Framework-iAccept/IAThenResult.h>

@implementation ShoppingCartFixture

-(IAThenResult*) containsTheCockatoo {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* promoTable = [IATableOperator tableOperatorForUITableView:(UITableView*)[[detailOperator searchForViewOfClass:[UITableView class]] uiView]]; 
    IAViewOperator* cellOperator = [promoTable searchForCellContainingALabelWithText:@"Cockatoo"];
    
    if (!cellOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected one cockatoo in shopping cart, none found."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)doesNotContainsTheCockatoo {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* promoTable = [IATableOperator tableOperatorForUITableView:(UITableView*)[[detailOperator searchForViewOfClass:[UITableView class]] uiView]]; 
    IAViewOperator* cellOperator = [promoTable searchForCellContainingALabelWithText:@"Cockatoo"];
    
    if (cellOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected no cockatoo in shopping cart, one found."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iTouchTheCheckoutButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IAButtonOperator* checkoutButton = [detailOperator searchForButtonWithText:@"Checkout" forState:UIControlStateNormal];
    
    [checkoutButton touch];
}

-(void)iTouchTheCockatooSwitch {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* promoTable = [IATableOperator tableOperatorForUITableView:(UITableView*)[[detailOperator searchForViewOfClass:[UITableView class]] uiView]]; 
    IAViewOperator* cellOperator = [promoTable searchForCellContainingALabelWithText:@"Cockatoo"];
    IAViewOperator* switchViewOperator = [cellOperator searchForViewOfClass:[UISwitch class]];
    IASwitchOperator* deleteSwitch = [IASwitchOperator switchOperatorForUISwitch:(UISwitch*)[switchViewOperator uiView]];
    
    [deleteSwitch touch];
}

-(void)iTouchTheDeleteButton{
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* promoTable = [IATableOperator tableOperatorForUITableView:(UITableView*)[[detailOperator searchForViewOfClass:[UITableView class]] uiView]]; 
    IAButtonOperator* deleteButton = [promoTable searchForButtonWithImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
   
    [deleteButton touch];
}


@end
