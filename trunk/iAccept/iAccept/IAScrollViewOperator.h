//
//  Created by Nicolas Desjardins on 12-02-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAScrollViewOperator : IAViewOperator

+(IAScrollViewOperator*)scrollViewOperatorForUIScrollView:(UIScrollView*)uiScrollView;

-(UIScrollView*)uiScrollView;

-(int)indexOfShownPage;

-(void)scrollToPageAtIndex:(int)index;

-(void)scrollToTop;

-(void)scrollToBottom;

-(CGPoint)contentOffset;

@end
