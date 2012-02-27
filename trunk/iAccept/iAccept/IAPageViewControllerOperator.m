//
//  Created by Nicolas Desjardins on 12-02-02.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAPageViewControllerOperator.h"

@implementation IAPageViewControllerOperator

+(IAPageViewControllerOperator*) pageViewControllerOperatorForUIPageViewController:(UIPageViewController*)uiPageViewController {
    IAPageViewControllerOperator* operator = [[IAPageViewControllerOperator alloc] init];
    [operator setUiViewController:uiPageViewController];
    return [operator autorelease]; 
}

-(UIPageViewController*)uiPageViewController {
    return (UIPageViewController*)self.uiViewController;
}

-(void)swipeToNextPage {
    UIPageViewController* pageViewController = [self uiPageViewController];
    UIViewController* nextVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerAfterViewController:[[pageViewController viewControllers] lastObject]];
    if (nextVC != nil) {
        [pageViewController setViewControllers:[[[NSArray alloc] initWithObjects:nextVC, nil] autorelease] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

-(void)swipeToPreviousPage {
    UIPageViewController* pageViewController = [self uiPageViewController];
    UIViewController* previousVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerBeforeViewController:[[pageViewController viewControllers] lastObject]];
    if (previousVC != nil) {
        [pageViewController setViewControllers:[[[NSArray alloc] initWithObjects:previousVC, nil] autorelease] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}

-(void)swipeToNextPageDouble {
    UIPageViewController* pageViewController = [self uiPageViewController];

    UIViewController* firstNewVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerAfterViewController:[[pageViewController viewControllers] lastObject]];
    UIViewController* secondNewVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerAfterViewController:firstNewVC];
    
    
    if (firstNewVC != nil && secondNewVC != nil) {
        [pageViewController setViewControllers:[[[NSArray alloc] initWithObjects:firstNewVC, secondNewVC, nil] autorelease] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

-(void)swipeToPreviousPageDouble {
    UIPageViewController* pageViewController = [self uiPageViewController];
    UIViewController* lastPreviousVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerBeforeViewController:[[pageViewController viewControllers] objectAtIndex:0]];
    UIViewController* firstPreviousVC = [[pageViewController dataSource] pageViewController:pageViewController viewControllerBeforeViewController:lastPreviousVC];
    
    if (firstPreviousVC != nil) {
        [pageViewController setViewControllers:[[[NSArray alloc] initWithObjects:firstPreviousVC, lastPreviousVC, nil] autorelease] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
}

@end
