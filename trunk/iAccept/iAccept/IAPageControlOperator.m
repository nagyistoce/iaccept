//
//  Created by Nicolas Desjardins on 12-02-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAPageControlOperator.h"

@implementation IAPageControlOperator

+(IAPageControlOperator*) pageControlOperatorForUIPageControl:(UIPageControl*)uiPageControl  {
    IAPageControlOperator* operator = [[IAPageControlOperator alloc] init];
    [operator setUiView:uiPageControl];
    return [operator autorelease];
}

-(UIPageControl*)uiPageControl {
    return (UIPageControl*)self.uiView;
}

-(void)touchDotAtIndex:(int)index {
    [self.uiPageControl setCurrentPage:index]; 
    [self.uiPageControl sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
