//
//  Created by Nicolas Desjardins on 12-02-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAScrollViewOperator.h"

@implementation IAScrollViewOperator

+(IAScrollViewOperator*) scrollViewOperatorForUIScrollView:(UIScrollView*)uiScrollView  {
    IAScrollViewOperator* operator = [[IAScrollViewOperator alloc] init];
    [operator setUiView:uiScrollView];
    return [operator autorelease];
}

-(UIScrollView*)uiScrollView {
    return (UIScrollView*)self.uiView;
}

-(void)scrollToPageAtIndex:(int)index {
    CGRect frame;
    frame.origin.x = self.uiScrollView.frame.size.width * index;
    frame.origin.y = 0;
    frame.size = self.uiScrollView.frame.size;
    [self.uiScrollView scrollRectToVisible:frame animated:YES];
    [[self.uiScrollView delegate] scrollViewDidScroll:self.uiScrollView];
}

-(int)indexOfShownPage {
    CGFloat pageWidth = self.uiScrollView.frame.size.width;
    return floor((self.uiScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

-(void)scrollToTop {
    [self.uiScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    [[self.uiScrollView delegate] scrollViewDidScrollToTop:self.uiScrollView];
}

-(void)scrollToBottom {
    CGPoint bottomOffset = CGPointMake(0, self.uiScrollView.contentSize.height - self.uiScrollView.bounds.size.height);
    [self.uiScrollView setContentOffset:bottomOffset animated:YES];
    [[self.uiScrollView delegate] scrollViewDidScroll:self.uiScrollView];
}

-(CGPoint)contentOffset {
    return self.uiScrollView.contentOffset;
}

@end