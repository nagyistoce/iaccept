//
//  AnimalWelfareFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "AnimalWelfareFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAToolbarOperator.h>
#import <Framework-iAccept/IAAlertViewOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IAPageControlOperator.h>
#import <Framework-iAccept/IAScrollViewOperator.h>

@implementation AnimalWelfareFixture

-(void)iTouchSendByEmail {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAToolbarOperator* toolbar = [detailViewOperator searchForToolbar];
    
    [toolbar touchButtonTitled:@"Send by e-mail"];
}

-(IAThenResult*)alertPopupShowsSentByEmail {
    IAAlertViewOperator* alert =  [IAAlertViewOperator alertViewOperator];
    
    NSString* title = [alert title];
    
    if (!alert || [title isEqualToString:@""]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected alert sent by e-mail"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iDismissAlertPopup {
    IAAlertViewOperator* alert =  [IAAlertViewOperator alertViewOperator];
    
    [alert touchCancelButton];
}

-(void)iTouchThePageControlMiddleDot {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAPageControlOperator* pageControl = [detailViewOperator searchForPageControl];
    
    [pageControl touchDotAtIndex:1];
    
}

-(IAThenResult*)welfareSecondPageIsShowing {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAScrollViewOperator* scrollOperator = [detailViewOperator searchForScrollView];

    if (!scrollOperator || [scrollOperator indexOfShownPage] != 1) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected page 2 of animal welfare"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iDragToSeePageThree {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAScrollViewOperator* scrollOperator = [detailViewOperator searchForScrollView];
    [scrollOperator scrollToPageAtIndex:2];
}

-(IAThenResult*)welfareThirdPageIsShowing {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAScrollViewOperator* scrollOperator = [detailViewOperator searchForScrollView];
    
    if (!scrollOperator || [scrollOperator indexOfShownPage] != 2) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected page 3 of animal welfare"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
