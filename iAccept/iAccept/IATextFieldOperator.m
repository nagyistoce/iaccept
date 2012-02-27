//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATextFieldOperator.h"

@implementation IATextFieldOperator

+(IATextFieldOperator*) textFieldOperatorForUITextField:(UITextField*)uiTextField {
    IATextFieldOperator* operator = [[[IATextFieldOperator alloc] init] autorelease];
    [operator setUiView:uiTextField];
    return operator;
}

-(NSString*)text {
    return self.uiTextField.text;
}

-(void)setText:(NSString*)text {
    [self.uiTextField becomeFirstResponder];
    self.uiTextField.text = text;
    [self.uiTextField resignFirstResponder]; 
    [self.uiTextField sendActionsForControlEvents:UIControlEventValueChanged];
}

-(UITextField*)uiTextField {
    return (UITextField*)[self uiView];
}

@end
