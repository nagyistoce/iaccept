//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAStepperOperator.h"

@implementation IAStepperOperator

+(IAStepperOperator*) stepperOperatorForUIStepper:(UIStepper*)uiStepper  {
    IAStepperOperator* operator = [[[IAStepperOperator alloc] init] autorelease];
    [operator setUiView:uiStepper];
    return operator; 
}

-(double)value {
    return [self.uiStepper value];
}

-(void)setValue:(double)value {
    [self.uiStepper setValue:value];
    [self.uiStepper sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)touchPlus {
    double step = self.uiStepper.stepValue;
    double value = self.value;
    
    [self setValue:value+step];
}

-(void)touchMinus {
    double step = self.uiStepper.stepValue;
    double value = self.value;
    
    [self setValue:value-step];
}

-(UIStepper*)uiStepper {
    return (UIStepper*)self.uiView;
}

@end
