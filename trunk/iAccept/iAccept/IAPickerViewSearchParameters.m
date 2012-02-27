//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAPickerViewSearchParameters.h"
#import "IAPickerOperator.h"

@implementation IAPickerViewSearchParameters

@synthesize titles;

+(IAPickerViewSearchParameters*) initWithTitles:(NSArray*)titles {
    IAPickerViewSearchParameters* parameters = [[[IAPickerViewSearchParameters alloc] init] autorelease];
    [parameters setTitles:titles];
    
    return parameters;
}

-(BOOL)containsAllTitles:(IAPickerOperator*)operator {
    for (NSString* title in titles) {
        if (![operator containsARowNamed:title]) {
            return NO;
        }
    }
    return YES;
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIPickerView class]]) {
        UIPickerView* picker = (UIPickerView*)view;
        IAPickerOperator* operator = [IAPickerOperator pickerOperatorForUIPickerView:picker];
        if ([self containsAllTitles:operator]) {
            [self setViewOperator:operator];
            return YES;
        }
    }
    return NO;
}



@end
