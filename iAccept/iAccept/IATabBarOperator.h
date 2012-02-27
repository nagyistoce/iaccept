//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IATabBarOperator : IAViewOperator

+(IATabBarOperator*) tabBarOperatorForUITabBar:(UITabBar*)uiTabBar;

-(UITabBarItem*)selectedItem;

-(NSString*)selectedItemTitle;

-(void)touchTabAtIndex:(int)index;

-(UITabBar*)uiTabBar;

@end
