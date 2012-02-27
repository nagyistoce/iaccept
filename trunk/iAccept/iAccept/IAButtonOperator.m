
//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAButtonOperator.h"

@implementation IAButtonOperator


+(IAButtonOperator*) buttonOperatorForUIButton:(UIButton*)button {
    IAButtonOperator* operator = [[[IAButtonOperator alloc] init] autorelease];
    [operator setUiView:button];
    return operator;
}

-(UIButton*)uiButton {
    return (UIButton*)[self uiView];
}

-(BOOL)isEnabled {
    return [self.uiButton isEnabled];
}

-(void) touch {
    [self.uiButton sendActionsForControlEvents:UIControlEventAllTouchEvents];
}

@end