//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IATextFieldOperator : IAViewOperator

+(IATextFieldOperator*) textFieldOperatorForUITextField:(UITextField*)uiTextField;

-(NSString*)text;

-(void)setText:(NSString*)text;

-(UITextField*)uiTextField;

@end
