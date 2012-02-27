//
//  Created by Nicolas Desjardins on 12-01-20.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IADatePickerOperator.h"

@implementation IADatePickerOperator

+(IADatePickerOperator*) datePickerOperatorForUIDatePicker:(UIDatePicker*)uiDatePicker {
    IADatePickerOperator* operator = [[IADatePickerOperator alloc] init];
    [operator setUiView:uiDatePicker];
    return [operator autorelease]; 
}

-(UIDatePicker*)uiDatePicker {
    return (UIDatePicker*)self.uiView;
}

-(NSDate*)date {
    return [self.uiDatePicker date];
}

-(void)setDate:(NSDate*)date {
    [self.uiDatePicker setDate:date];
    [self.uiDatePicker sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)setDate:(NSString*)date withFormat:(NSString*)format {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:format];
    NSDate *nsDate = [dateFormatter dateFromString:date];
    [self setDate:nsDate];
}

@end
