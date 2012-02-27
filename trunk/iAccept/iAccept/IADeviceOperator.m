//
//  Created by Nicolas Desjardins on 12-01-17.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IADeviceOperator.h"

@implementation IADeviceOperator

+(void)forceLandscapeOrientation {
    if ([[UIDevice currentDevice] orientation] != UIDeviceOrientationLandscapeLeft) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    } 
}

+(void)forcePortraitOrientation {
    if ([[UIDevice currentDevice] orientation] != UIDeviceOrientationPortrait) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIDeviceOrientationPortrait] forKey:@"orientation"];
    } 
}

@end
