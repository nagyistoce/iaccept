//
//  PromotionsFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PromotionsFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import <Framework-iAccept/IATabBarOperator.h>
#import <Framework-iAccept/IATabBarControllerOperator.h>

@implementation PromotionsFixture

-(void)iTouchTheMoreTabButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    
    IATabBarOperator* tabBar = (IATabBarOperator*)[detailOperator searchForViewOfClass:[UITabBar class]];
    [tabBar touchTabAtIndex:2];
}

-(void) iTouchTheBuyNowButtonForTheCockatoo {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator detailViewOperator];
    IATableOperator* promoTable = [IATableOperator tableOperatorForUITableView:(UITableView*)[[detailOperator searchForViewOfClass:[UITableView class]] uiView]];
    IAViewOperator* cellOperator = [promoTable cellForRow:0 inSection:0];
    IAButtonOperator* buttonOperator = [cellOperator searchForButtonWithText:@"Buy now!" forState:UIControlStateNormal];
    
    [buttonOperator touch];
}

@end
