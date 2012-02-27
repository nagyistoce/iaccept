//
//  Created by Nicolas Desjardins on 12-01-10.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IASplitViewOperator : NSObject

@property(strong, nonatomic) UISplitViewController* splitViewController;

+(IASplitViewOperator*) splitViewOperatorForAppDelegate:(id<UIApplicationDelegate>)applicationDelegate;
+(IASplitViewOperator*) splitViewOperatorForSplitView:(UISplitViewController*)splitViewController;

-(UIViewController*) masterViewController;
-(UIViewController*) detailViewController;

-(UIViewController*) rootViewOfMasterViewController;
-(UIViewController*) rootViewOfDetailViewController;

-(IAViewOperator*) masterViewOperator;
-(IAViewOperator*) detailViewOperator;

-(IAViewOperator*) rootViewOfMasterViewOperator;
-(IAViewOperator*) rootViewOfDetailViewOperator;
    
@end
