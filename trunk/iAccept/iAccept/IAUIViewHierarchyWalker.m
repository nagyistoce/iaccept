//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IAUIViewHierarchyWalker.h"

@implementation IAUIViewHierarchyWalker


+(void)hierarchyDepth:(UIView*)view underDepth:(int)initialDepth inDictionary:(NSMutableDictionary*)dic {
    if([view subviews] == nil || [[view subviews] count] == 0) {
        [dic setObject:view forKey:[NSNumber numberWithInt:initialDepth]];
    } else {
        for (UIView* subView in [view subviews]) {
            [self hierarchyDepth:subView underDepth:initialDepth+1 inDictionary:dic];
        }
    }
}

+(UIView*)findTopChildUIViewFromUIView:(UIView*)root {
    
    NSMutableDictionary* viewsDepth = [[[NSMutableDictionary alloc] init] autorelease];
    
    [self hierarchyDepth:root underDepth:0 inDictionary:viewsDepth];

    NSEnumerator* enumerator = [viewsDepth keyEnumerator];
    NSNumber* depth = [NSNumber numberWithInt:0];
    NSNumber* currentDepth;
    while (currentDepth = (NSNumber*)[enumerator nextObject]) {
        if ([currentDepth intValue] > [depth intValue]) {
            depth = currentDepth;
        }
    }
    
    return [viewsDepth objectForKey:depth];
}

@end
