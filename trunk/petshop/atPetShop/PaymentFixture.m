//
//  PaymentFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PaymentFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IATabBarOperator.h>
#import <Framework-iAccept/IATabBarControllerOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IAStepperOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import <Framework-iAccept/IASegmentedControlOperator.h>
#import <Framework-iAccept/IAActivityIndicatorOperator.h>
#import <Framework-iAccept/IAWebViewOperator.h>

@implementation PaymentFixture

-(void)iTouchCreditCardPaymentOption {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATabBarControllerOperator* tabBarCtlOp = (IATabBarControllerOperator*)[detailOperator searchForTopViewControllerOfClass:[UITabBarController class]];
    [tabBarCtlOp setSelectedIndex:1];
}

-(void)selectDebitCardPaymentOption {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATabBarOperator* tabBar = (IATabBarOperator*)[detailOperator searchForViewOfClass:[UITabBar class]];
    [tabBar touchTabAtIndex:0];
}

-(void)iTouchMore {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATabBarControllerOperator* tabBarCtlOp = (IATabBarControllerOperator*)[detailOperator searchForTopViewControllerOfClass:[UITabBarController class]];
    [tabBarCtlOp selectMore];
}


-(IAThenResult*)displaysTheAlternativePaymentCreditNote {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IALabelOperator* label = [detailOperator searchForLabelWithText:@"Credit Note"];
    IAStepperOperator* stepper = (IAStepperOperator*)[detailOperator searchForViewOfClass:[UIStepper class]];
    
    if (!label || !stepper) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected credit note payment screen."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)displaysTheMoreTable {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATableOperator* moreTable = (IATableOperator*)[detailOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* cell = [moreTable searchForCellContainingALabelWithText:@"Credit Note"];
        
    if (!cell) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected more table."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iChangeDepositValueWithFourStepperPlusTouch {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAStepperOperator* stepper = (IAStepperOperator*)[detailOperator searchForViewOfClass:[UIStepper class]];
    
    [stepper touchPlus];
    [stepper touchPlus];
    [stepper touchPlus];
    [stepper touchPlus];
}

-(void)iChangeDepositValueWithFourStepperMinusTouch {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAStepperOperator* stepper = (IAStepperOperator*)[detailOperator searchForViewOfClass:[UIStepper class]];
    
    [stepper touchMinus];
    [stepper touchMinus];
    [stepper touchMinus];
    [stepper touchMinus];
}

-(IAThenResult*)theDepositIsFiveHundred {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAStepperOperator* stepper = (IAStepperOperator*)[detailOperator searchForViewOfClass:[UIStepper class]];
    
    if (!stepper || (int)[stepper value] != 519) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected stepper with value 519."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)theDepositIsMinimum {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAStepperOperator* stepper = (IAStepperOperator*)[detailOperator searchForViewOfClass:[UIStepper class]];
    
    if (!stepper || (int)[stepper value] != 319) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected stepper with value 319"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iTouchTheInShopPaymentMode {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IASegmentedControlOperator* operator =  [detailOperator searchForSegmentedControlContainingTitles:[NSArray arrayWithObjects:@"Online", @"In Store", nil]];

    [operator selectWithIndex:1];
}

-(IAThenResult*)theInStorePaymentModeIsSelected {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IASegmentedControlOperator* operator =  [detailOperator searchForSegmentedControlContainingTitles:[NSArray arrayWithObjects:@"Online", @"In Store", nil]];

    if (!operator || [operator selectedIndex] != 1) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected In Store payment mode"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iSelectCreditNote {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATabBarControllerOperator* tabBarCtlOp = (IATabBarControllerOperator*)[detailOperator searchForTopViewControllerOfClass:[UITabBarController class]];
    [tabBarCtlOp selectMoreItemNamed:@"Credit Note"];
}

-(void)iTouchTheConfirmButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAActivityIndicatorOperator* indicator = [detailOperator searchForActivityIndicator];
    
    if (![indicator isAnimating]) {
        IAButtonOperator* confirm = (IAButtonOperator*)[detailOperator searchForButtonWithText:@"Confirm" forState:UIControlStateNormal];
        [confirm touch];
    } else {
        [self performSelector:@selector(iTouchTheConfirmButton) withObject:nil afterDelay:0.2];
    }    
}

-(IAThenResult*)webPortalLoaded {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAActivityIndicatorOperator* indicator = [detailOperator searchForActivityIndicator];
    IAWebViewOperator* webView = (IAWebViewOperator*)[detailOperator searchForWebView];
    
    BOOL isAnimating = [indicator isAnimating];
    NSString* loadedUrl = [webView loadedURL];
    BOOL isLoading = [webView isLoading];
    
    if (isAnimating || !webView || isLoading || ![loadedUrl isEqualToString:@"http://www.elapsetech.com/"]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected payment website to be loaded"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
