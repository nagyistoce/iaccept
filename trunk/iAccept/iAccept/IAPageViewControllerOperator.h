//
//  Created by Nicolas Desjardins on 12-02-02.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAControllerOperator.h>

@interface IAPageViewControllerOperator : IAControllerOperator

+(IAPageViewControllerOperator*) pageViewControllerOperatorForUIPageViewController:(UIPageViewController*)uiPageViewController;

-(UIPageViewController*)uiPageViewController;
-(void)swipeToNextPage;
-(void)swipeToPreviousPage;
-(void)swipeToNextPageDouble;
-(void)swipeToPreviousPageDouble;

@end
