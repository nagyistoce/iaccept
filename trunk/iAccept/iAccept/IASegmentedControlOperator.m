//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASegmentedControlOperator.h"

@implementation IASegmentedControlOperator

+(IASegmentedControlOperator*) segmentedControlOperatorForUISegmentedControl:(UISegmentedControl*)uiSegmentedControl {
    IASegmentedControlOperator* operator = [[[IASegmentedControlOperator alloc] init] autorelease];
    [operator setUiView:uiSegmentedControl];
    return operator;
}

-(UISegmentedControl*)uiSegmentedControl {
    return (UISegmentedControl*)[self uiView];
}

-(NSInteger)selectedIndex {
    return [self.uiSegmentedControl selectedSegmentIndex];
}

-(NSString*)titleForIndex:(NSInteger)index {
    return [self.uiSegmentedControl titleForSegmentAtIndex:index];
}

-(void)selectWithIndex:(NSInteger)index {
    [self.uiSegmentedControl setSelectedSegmentIndex:index];
    [self.uiSegmentedControl sendActionsForControlEvents:UIControlEventValueChanged];
}


-(BOOL)containsTitle:(NSString*)title {
    NSInteger segmentCount = [self.uiSegmentedControl numberOfSegments];
    
    NSString* currentTitle;
    for (int i=0;i<segmentCount;i++) {
        currentTitle = [self.uiSegmentedControl titleForSegmentAtIndex:i];
        if ([title isEqualToString:currentTitle]) {
            return YES;
        }
    }
    return NO;
}

-(void)selectWithTitle:(NSString*)title {
    NSInteger segmentCount = [self.uiSegmentedControl numberOfSegments];
    
    NSString* currentTitle;
    for (int i=0;i<segmentCount;i++) {
        currentTitle = [self.uiSegmentedControl titleForSegmentAtIndex:i];
        if ([title isEqualToString:currentTitle]) {
            [self selectWithIndex:i];
            break;
        }
    }
}

@end
