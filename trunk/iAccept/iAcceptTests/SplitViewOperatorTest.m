//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "SplitViewOperatorTest.h"
#import "IASplitViewOperator.h"

@implementation SplitViewOperatorTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetViewControllersWithoutNavController
{
    UISplitViewController* splitViewController = [[UISplitViewController alloc] init];
    UIViewController* controller1 = [[UIViewController alloc]init];
    UIViewController* controller2 = [[UIViewController alloc]init];
    NSArray* controllers = [NSArray arrayWithObjects:controller1, controller2, nil];
    splitViewController.viewControllers = controllers;
    
    IASplitViewOperator* operator = [IASplitViewOperator splitViewOperatorForSplitView:splitViewController];

    UIViewController* master = [operator masterViewController];
    UIViewController* detail = [operator detailViewController];
    STAssertEqualObjects(master, controller1, @"", nil);
    STAssertEqualObjects(detail, controller2, @"", nil);
}

- (void)testGetViewControllersWithNavController
{
    UISplitViewController* splitViewController = [[UISplitViewController alloc] init];
    UIViewController* controller1 = [[UIViewController alloc]init];
    UIViewController* controller2 = [[UIViewController alloc]init];
    UINavigationController* navcontroller1 = [[UINavigationController alloc] initWithRootViewController:controller1];
    UINavigationController* navcontroller2 = [[UINavigationController alloc] initWithRootViewController:controller2];
    
    NSArray* controllers = [NSArray arrayWithObjects:navcontroller1, navcontroller2, nil];
    splitViewController.viewControllers = controllers;
    
    IASplitViewOperator* operator = [IASplitViewOperator splitViewOperatorForSplitView:splitViewController];
    
    UIViewController* master = [operator masterViewController];
    UIViewController* detail = [operator detailViewController];
    STAssertEqualObjects(master, controller1, @"", nil);
    STAssertEqualObjects(detail, controller2, @"", nil);
}

- (void)testGetDirectViewControllers
{
    UISplitViewController* splitViewController = [[UISplitViewController alloc] init];
    UIViewController* controller1 = [[UIViewController alloc]init];
    UIViewController* controller2 = [[UIViewController alloc]init];
    UINavigationController* navcontroller1 = [[UINavigationController alloc] initWithRootViewController:controller1];
    UINavigationController* navcontroller2 = [[UINavigationController alloc] initWithRootViewController:controller2];
    
    NSArray* controllers = [NSArray arrayWithObjects:navcontroller1, navcontroller2, nil];
    splitViewController.viewControllers = controllers;
    
    IASplitViewOperator* operator = [IASplitViewOperator splitViewOperatorForSplitView:splitViewController];
    
    UIViewController* master = [operator rootViewOfMasterViewController];
    UIViewController* detail = [operator rootViewOfDetailViewController];
    STAssertEqualObjects(master, navcontroller1, @"", nil);
    STAssertEqualObjects(detail, navcontroller2, @"", nil);
}

@end
