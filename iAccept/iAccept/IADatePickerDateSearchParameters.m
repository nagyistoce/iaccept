//
//  Created by Nicolas Desjardins on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IADatePickerDateSearchParameters.h"
#import "IAOperatorFactory.h"

@implementation IADatePickerDateSearchParameters

@synthesize date = _date;

+(IADatePickerDateSearchParameters*) initWithFormat:(NSString*)format forDate:(NSString*)date {
    IADatePickerDateSearchParameters* parameters = [[IADatePickerDateSearchParameters alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *nsDate = [dateFormatter dateFromString:date];
    [dateFormatter release];
    
    [parameters setDate:nsDate];
    return [parameters autorelease];
}

-(BOOL)keepThisView:(UIView*)view {
    if ([view isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker* picker = (UIDatePicker*)view;
        NSDate* pickerDate = [picker date];
        if ([pickerDate isEqualToDate:_date]) {
            [self setViewOperator:[IAOperatorFactory createOperatorForUIView:view]];
            return YES;
        }
    }
    return NO;
}

@end
