//
//  Created by Nicolas Desjardins on 12-02-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAPageControlOperator : IAViewOperator

+(IAPageControlOperator*)pageControlOperatorForUIPageControl:(UIPageControl*)uiPageControl;

-(UIPageControl*)uiPageControl;

-(void)touchDotAtIndex:(int)index;

@end
