//
//  MainViewFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-10.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "MainViewFixture.h"

#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IALabelOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import <Framework-iAccept/IATableOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IATextViewOperator.h>
#import "ETCreditCardPaymentViewController.h"
#import "ETPaymentDoneViewController.h"
#import "ETLegalDisclaimerPage1ViewController.h"
#import "ETLegalDisclaimerPage2ViewController.h"
#import "ETLegalDisclaimerPage3ViewController.h"
#import "ETStorePolicyController.h"
#import "ETAnimalWellfareViewController.h"

@implementation MainViewFixture

-(IAThenResult*) displaysTheDogList {
    NSString* dogs = @"Dogs";
    
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];  
    IAViewOperator* detailOperator = (IAViewOperator*)[splitOperator detailViewOperator];
    IALabelOperator* labelOperator = [detailOperator searchForLabelWithText:dogs];
 
    if (!labelOperator || ![[labelOperator text] isEqualToString:dogs]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected animal dogs list displayed, was not."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysTheCatList {
    NSString* cats = @"Cats";
    
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]];  
    IAViewOperator* detailOperator = (IAViewOperator*)[splitOperator detailViewOperator];
    IALabelOperator* labelOperator = [detailOperator searchForLabelWithText:cats];
    
    if (!labelOperator || ![[labelOperator text] isEqualToString:cats]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected animal cats list displayed, was not."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysTheShoppingCart {
    NSString* title = @"Shopping Cart";
    
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    IANavigationBarOperator* navBar = [detailViewOperator searchForNavigationBarWithTitle:title];

    if (!navBar || ![[navBar title] isEqualToString:title]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", title, [navBar title]] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysThePromotions {
    NSString* title = @"Manager's Deals Of The Week!";
    
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    IANavigationBarOperator* navBar = [detailViewOperator searchForNavigationBarWithTitle:title];
    
    if (!navBar || ![[navBar title] isEqualToString:title]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", title, [navBar title]] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysThePolicy {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    ETStorePolicyController* policyViewController = (ETStorePolicyController*)[detailViewOperator searchForTopViewControllerOfClass:[ETStorePolicyController class]];
    
    if (!policyViewController) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page 1 & 2 of policy"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

- (IAThenResult*)lookForPolicyText:(NSString *)policyText {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATextViewOperator* textView = (IATextViewOperator*)[detailViewOperator searchForTextViewContainingText:policyText];
    
    if (!textView) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page one of policy"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysPageOneOfPolicy {
    return [self lookForPolicyText:@"Policy 1"];
}

-(IAThenResult*) displaysPageTwoOfPolicy {
    return [self lookForPolicyText:@"Policy 2"];
}

-(IAThenResult*) displaysPageTreeOfPolicy {
    return [self lookForPolicyText:@"Policy 3"];
}

-(IAThenResult*) displaysPageFourOfPolicy {
    return [self lookForPolicyText:@"Policy 4"];
}

-(IAThenResult*) displaysTheDisclaimer {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    ETLegalDisclaimerPage1ViewController* page1ViewController = (ETLegalDisclaimerPage1ViewController*)[detailViewOperator searchForTopViewControllerOfClass:[ETLegalDisclaimerPage1ViewController class]];

    if (!page1ViewController) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page 1 displayed"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysAnimalWelfare {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    ETAnimalWellfareViewController* controller = (ETAnimalWellfareViewController*)[detailViewOperator searchForTopViewControllerOfClass:[ETAnimalWellfareViewController class]];
    
    if (!controller) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected animal welfare displayed"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}


-(IAThenResult*) displaysPageOneOfDisclaimer {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    ETLegalDisclaimerPage1ViewController* page1ViewController = (ETLegalDisclaimerPage1ViewController*)[detailViewOperator searchForTopViewControllerOfClass:[ETLegalDisclaimerPage1ViewController class]];
    
    if (!page1ViewController) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page 1 displayed"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysPageTwoOfDisclaimer {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];

    ETLegalDisclaimerPage2ViewController* page2ViewController = (ETLegalDisclaimerPage2ViewController*)[detailViewOperator searchForTopViewControllerOfClass:[ETLegalDisclaimerPage2ViewController class]];
    
    if (!page2ViewController) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page 2 displayed"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysPageThreeOfDisclaimer {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    ETLegalDisclaimerPage3ViewController* page3ViewController = (ETLegalDisclaimerPage3ViewController*)[detailViewOperator searchForTopViewControllerOfClass:[ETLegalDisclaimerPage3ViewController class]];
    
    if (!page3ViewController) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected page 3 displayed"] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}


-(IAThenResult*) displaysTheCreditCardPayment {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    NSArray* views = [detailOperator searchForViewsDelegatingToClass:[ETCreditCardPaymentViewController class]];
    IAViewOperator* paymentViewOperator;
    if ([views count] > 0) {
        paymentViewOperator = [views objectAtIndex:0];
    }
    
    if (!paymentViewOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", [paymentViewOperator uiView]] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*) displaysThanksScreen {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    NSArray* views = [detailOperator searchForViewsDelegatingToClass:[ETPaymentDoneViewController class]];
    IAViewOperator* thanksViewOperator;
    if ([views count] > 0) {
        thanksViewOperator = [views objectAtIndex:0];
    }
    
    if (!thanksViewOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected @% displayed, but was @%.", [thanksViewOperator uiView]] ];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
