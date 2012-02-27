//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAControllerOperatorFactory.h"
#import "IAPageViewControllerOperator.h"
#import "IATabBarControllerOperator.h"

@implementation IAControllerOperatorFactory

+(IAControllerOperator*)createControllerOperatorForUIViewController:(UIViewController*)uiViewController {
    if ([uiViewController isKindOfClass:[UIPageViewController class]]) {
        return (IAControllerOperator*)[IAPageViewControllerOperator pageViewControllerOperatorForUIPageViewController:(UIPageViewController*)uiViewController];
    } else if ([uiViewController isKindOfClass:[UITabBarController class]]) { 
        return (IAControllerOperator*)[IATabBarControllerOperator tabBarControllerOperatorForUITabBarController:(UITabBarController*)uiViewController];
    } else {
        return [IAControllerOperator createControllerOperatorForUIViewController:uiViewController];
    } 
}
@end
