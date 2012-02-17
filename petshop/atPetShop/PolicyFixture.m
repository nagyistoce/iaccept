//
//  PolicyFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PolicyFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAPageViewControllerOperator.h>

@implementation PolicyFixture

-(void)showNextPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAPageViewControllerOperator* pageViewController = (IAPageViewControllerOperator*)[detailViewOperator searchForTopViewControllerOfClass:[UIPageViewController class]];
    
    [pageViewController swipeToNextPageDouble]; 
}

-(void)showPreviousPage {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    
    IAPageViewControllerOperator* pageViewController = (IAPageViewControllerOperator*)[detailViewOperator searchForTopViewControllerOfClass:[UIPageViewController class]];
    
    [pageViewController swipeToPreviousPageDouble]; 
}



@end
