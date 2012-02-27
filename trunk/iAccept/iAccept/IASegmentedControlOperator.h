//
//  Created by Nicolas Desjardins on 12-02-08.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IASegmentedControlOperator : IAViewOperator

+(IASegmentedControlOperator*) segmentedControlOperatorForUISegmentedControl:(UISegmentedControl*)uiSegmentedControl;

-(UISegmentedControl*)uiSegmentedControl;

-(NSInteger)selectedIndex;
-(NSString*)titleForIndex:(NSInteger)index;
-(void)selectWithIndex:(NSInteger)index;
-(void)selectWithTitle:(NSString*)title;
-(BOOL)containsTitle:(NSString*)title;

@end
