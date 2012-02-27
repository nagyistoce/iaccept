//
//  Created by Nicolas Desjardins on 12-01-10.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASplitViewOperator.h"

@interface IASplitViewOperator()

-(BOOL) isANavigationController:(UIViewController*)viewController;
-(id) findFirstNonNavigationController:(id)viewController;

@end

@implementation IASplitViewOperator

@synthesize splitViewController = _splitViewController;

+(IASplitViewOperator*) splitViewOperatorForAppDelegate:(id<UIApplicationDelegate>)applicationDelegate {
    IASplitViewOperator* operator = [[IASplitViewOperator alloc] init];
    [operator setSplitViewController:(UISplitViewController*)[[applicationDelegate window] rootViewController]];
    return [operator autorelease];
}

+(IASplitViewOperator*) splitViewOperatorForSplitView:(UISplitViewController*)splitViewController {
    IASplitViewOperator* operator = [[IASplitViewOperator alloc] init];
    [operator setSplitViewController:splitViewController];
    return [operator autorelease];
}

-(BOOL) isANavigationController:(UIViewController*)viewController {
    return [viewController isKindOfClass:[UINavigationController class]];
}

-(id) findFirstNonNavigationController:(id)viewController {
    while ([self isANavigationController:viewController]) {
        viewController = [[viewController viewControllers] objectAtIndex:0];
    }
    return viewController;
}

-(UIViewController*) masterViewController {
    id viewController = [[_splitViewController viewControllers] objectAtIndex:0];
    viewController = [self findFirstNonNavigationController:viewController]; 
    return viewController;
}

-(UIViewController*) detailViewController {
    id viewController = [[_splitViewController viewControllers] objectAtIndex:1];
    viewController = [self findFirstNonNavigationController:viewController]; 
    return viewController;
}

-(UIViewController*) rootViewOfMasterViewController {
    return [[_splitViewController viewControllers] objectAtIndex:0];
}

-(UIViewController*) rootViewOfDetailViewController {
    return [[_splitViewController viewControllers] objectAtIndex:1];
}

-(IAViewOperator*) masterViewOperator {
    UIView* view = [[self masterViewController] view];
    return [IAViewOperator viewOperatorForUIView:view];
}

-(IAViewOperator*) detailViewOperator {
    UIView* view = [[self detailViewController] view];
    return [IAViewOperator viewOperatorForUIView:view];
}

-(IAViewOperator*) rootViewOfMasterViewOperator {
    UIView* view = [[self rootViewOfMasterViewController] view];
    return [IAViewOperator viewOperatorForUIView:view];
}

-(IAViewOperator*) rootViewOfDetailViewOperator {
    UIView* view = [[self rootViewOfDetailViewController] view];
    return [IAViewOperator viewOperatorForUIView:view];
}


@end