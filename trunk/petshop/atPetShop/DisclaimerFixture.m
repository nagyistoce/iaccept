//
//  DisclaimerFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "DisclaimerFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAPageViewControllerOperator.h>
#import <Framework-iAccept/IAScrollViewOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IATextViewOperator.h>

@implementation DisclaimerFixture 

-(void)showNextPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAPageViewControllerOperator* pageViewController = (IAPageViewControllerOperator*)[detailViewOperator searchForTopViewControllerOfClass:[UIPageViewController class]];
    
    [pageViewController swipeToNextPage]; 
}

-(void)showPreviousPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAPageViewControllerOperator* pageViewController = (IAPageViewControllerOperator*)[detailViewOperator searchForTopViewControllerOfClass:[UIPageViewController class]];
    
    [pageViewController swipeToPreviousPage]; 
}

-(void)iScrollToTheBottomOfTheFirstPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATextViewOperator* textView = [detailViewOperator searchForTextViewContainingText:@"1. Acceptance"];
    IAScrollViewOperator* scroll = [textView scrollViewOperator];
    
    [scroll scrollToBottom];
}

-(IAThenResult*) iSeeTheBottomOfThePage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATextViewOperator* textView = [detailViewOperator searchForTextViewContainingText:@"1. Acceptance"];
    IAScrollViewOperator* scroll = [textView scrollViewOperator];
    
    CGPoint offset = [scroll contentOffset];

    if (offset.y == 0) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected the scroll to be at bottom"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iScrollToTheTopOfTheFirstPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATextViewOperator* textView = [detailViewOperator searchForTextViewContainingText:@"1. Acceptance"];
    IAScrollViewOperator* scroll = [textView scrollViewOperator];
    
    [scroll scrollToTop];
}

-(IAThenResult*) iSeeTheTopOfThePage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IATextViewOperator* textView = [detailViewOperator searchForTextViewContainingText:@"1. Acceptance"];
    IAScrollViewOperator* scroll = [textView scrollViewOperator];
    
    CGPoint offset = [scroll contentOffset];
    
    if (offset.y != 0) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected the scroll to be at top"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
