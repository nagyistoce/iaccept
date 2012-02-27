//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IASliderOperator : IAViewOperator

+(IASliderOperator*) sliderOperatorForUISlider:(UISlider*)uiSlider;

-(int)value;
-(void)setValue:(int)value;

-(UISlider*)uiSlider;

@end
