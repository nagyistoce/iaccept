//
//  MenuViewFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-10.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "MenuViewFixture.h"

#import "ETAppDelegate.h"
#import "ETMasterViewController.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>

@implementation MenuViewFixture

-(void) iTouchTheDogMenuItem {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IATableOperator* tableOperator = [IATableOperator tableOperatorForUITableView:(UITableView*)[[splitOperator masterViewOperator] uiView]];
    
    [tableOperator selectRow:0 inSection:0];
}

-(void) iTouchTheCatMenuItem {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IATableOperator* tableOperator = [IATableOperator tableOperatorForUITableView:(UITableView*)[[splitOperator masterViewOperator] uiView]];
        
    [tableOperator selectRow:0 inSection:1];
}

-(void) iTouchTheShoppingCartButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];

    IAButtonOperator* shoppingCartButton = [masterViewOperator searchForButtonWithImage:[UIImage imageNamed:@"shopping_trolley.png"] forState:UIControlStateNormal];
    [shoppingCartButton touch]; 
}
        
-(void) iTouchThePromoButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* promoButton = [masterViewOperator searchForButtonWithImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [promoButton touch]; 
}

-(void) iTouchTheDisclaimer {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* disclaimerButton = [masterViewOperator searchForButtonWithText:@"Disclaimer" forState:UIControlStateNormal];
    [disclaimerButton touch]; 
}

-(void) iTouchThePolicy {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* policyButton = [masterViewOperator searchForButtonWithText:@"Policy" forState:UIControlStateNormal];
    [policyButton touch]; 
}

-(void) iTouchAnimalWelfare {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];
    IAViewOperator* masterViewOperator = [splitOperator masterViewOperator];
    
    IAButtonOperator* button = [masterViewOperator searchForButtonWithText:@"Animal Welfare" forState:UIControlStateNormal];
    [button touch]; 
}

@end
