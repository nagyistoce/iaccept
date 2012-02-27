//
//  Created by Nicolas Desjardins on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASwitchOperator.h"

@implementation IASwitchOperator

+(IASwitchOperator*) switchOperatorForUISwitch:(UISwitch*)uiSwitch {
    IASwitchOperator* operator = [[IASwitchOperator alloc] init];
    [operator setUiView:uiSwitch];
    return [operator autorelease]; 
}

-(UISwitch*)uiSwitch {
    return (UISwitch*)self.uiView;
}

-(void)touch {
    [self.uiSwitch setOn:!self.uiSwitch.isOn animated:NO];
    [self.uiSwitch sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
