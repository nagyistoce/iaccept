//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATabBarControllerOperator.h"
#import "IAViewOperator.h"
#import "IATableOperator.h"

@implementation IATabBarControllerOperator

+(IATabBarControllerOperator*) tabBarControllerOperatorForUITabBarController:(UITabBarController*)uiTabBarController {
    IATabBarControllerOperator* operator = [[IATabBarControllerOperator alloc] init];
    [operator setUiViewController:uiTabBarController];
    return [operator autorelease]; 
}

-(UITabBarController*)uiTabBarController {
    return (UITabBarController*)[self uiViewController];
}

-(int)selectedIndex {
    return [[self uiTabBarController] selectedIndex];
}

-(void)setSelectedIndex:(int)index {
    [[self uiTabBarController] setSelectedIndex:index];
}

-(UINavigationController*)moreNavigationController {
    return [self uiTabBarController].moreNavigationController;
}

-(void)selectMore {
    [[self uiTabBarController] setSelectedViewController:[self moreNavigationController]];
}

-(void)selectMoreItemNamed:(NSString*)name {
    UINavigationController* moreNavigationController = [self moreNavigationController];

    IAViewOperator* moreRootViewOperator = [IAViewOperator viewOperatorForUIView:[moreNavigationController view]];
    IATableOperator* tableOperator = (IATableOperator*)[moreRootViewOperator searchForViewOfClass:[UITableView class]];
    IAViewOperator* cell = [tableOperator searchForCellContainingALabelWithText:name]; 
    
    [tableOperator selectCell:cell];
}

-(void)selectMoreItemAtIndex:(int)index {
    UINavigationController* moreNavigationController = [self moreNavigationController];

    IAViewOperator* moreRootViewOperator = [IAViewOperator viewOperatorForUIView:[moreNavigationController view]];
    IATableOperator* tableOperator = (IATableOperator*)[moreRootViewOperator searchForViewOfClass:[UITableView class]];
    
    [tableOperator selectRow:index inSection:0];
}

@end
