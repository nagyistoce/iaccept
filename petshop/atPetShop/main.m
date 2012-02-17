//
//  main.m
//  atPetShop
//
//  Created by Nicolas Desjardins on 12-01-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Framework-iAccept/IARunner.h>
#import <Framework-iAccept/IADefaultRunnerExitHandler.h>
#import <Framework-iAccept/IAConfig.h>
#import "ETAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        
        IARunner* runner = [[IARunner alloc]init];
        [runner addObserver:[[IADefaultRunnerExitHandler alloc] init]];
        [[IAConfig sharedInstance] setDelayBetweenTestsInSeconds:0.1];
        [[IAConfig sharedInstance] setDelayBetweenTestStatementsInSeconds:0.4];
        
        [runner runAfterDelay:1];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([ETAppDelegate class]));
    }
}