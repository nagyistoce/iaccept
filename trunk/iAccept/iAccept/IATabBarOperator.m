//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATabBarOperator.h"

@implementation IATabBarOperator

+(IATabBarOperator*) tabBarOperatorForUITabBar:(UITabBar*)uiTabBar {
    IATabBarOperator* operator = [[[IATabBarOperator alloc] init] autorelease];
    [operator setUiView:uiTabBar];
    return operator; 
}

-(UITabBarItem*)selectedItem {
    return [self.uiTabBar selectedItem];
}

-(NSString*)selectedItemTitle {
    return [[self.uiTabBar selectedItem] title];
}

- (void)touchWhenNotControlledByAController:(int)index {
    NSArray* items = [self.uiTabBar items];
    @try {
        UITabBarItem* item = [items objectAtIndex:index];
        [self.uiTabBar setSelectedItem:item];
        [[self.uiTabBar delegate] tabBar:self.uiTabBar didSelectItem:item];
    } @catch (NSException *exception) {
        NSLog(@"Could not select tab bar item");
    }
}

-(void)touchTabAtIndex:(int)index {
    id<UITabBarDelegate> delegate = [self.uiTabBar delegate];
    if ([delegate isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarControler = (UITabBarController*)delegate;
        [tabBarControler setSelectedIndex:index];
    } else {
        [self touchWhenNotControlledByAController:index];
    }
    return;
}

-(UITabBar*)uiTabBar {
    return (UITabBar*)[self uiView];
}

@end
