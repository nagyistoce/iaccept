//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASliderOperator.h"

@implementation IASliderOperator

+(IASliderOperator*) sliderOperatorForUISlider:(UISlider*)uiSlider {
    IASliderOperator* operator = [[IASliderOperator alloc] init];
    [operator setUiView:uiSlider];
    return [operator autorelease]; 
}

-(int)value {
    return [self.uiSlider value];
}

-(void)setValue:(int)value {
    [self.uiSlider setValue:value];
    [self.uiSlider sendActionsForControlEvents:UIControlEventValueChanged];
}

-(UISlider*)uiSlider {
    return (UISlider*)self.uiView;
}

@end
