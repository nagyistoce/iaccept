//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAStepperOperator : IAViewOperator

+(IAStepperOperator*) stepperOperatorForUIStepper:(UIStepper*)uiSlider;

-(double)value;
-(void)setValue:(double)value;

-(void)touchPlus;
-(void)touchMinus;

-(UIStepper*)uiStepper;
@end
