//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAControllerOperator.h>

@interface IATabBarControllerOperator : IAControllerOperator

+(IATabBarControllerOperator*) tabBarControllerOperatorForUITabBarController:(UITabBarController*)uiTabBarController;

-(UITabBarController*)uiTabBarController;

-(int)selectedIndex;

-(void)setSelectedIndex:(int)index;

-(UINavigationController*)moreNavigationController;

-(void)selectMore;

-(void)selectMoreItemNamed:(NSString*)name;

-(void)selectMoreItemAtIndex:(int)index;

@end
