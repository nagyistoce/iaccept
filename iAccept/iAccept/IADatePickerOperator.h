//
//  Created by Nicolas Desjardins on 12-01-20.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IAViewOperator.h>

@interface IADatePickerOperator : IAViewOperator

+(IADatePickerOperator*) datePickerOperatorForUIDatePicker:(UIDatePicker*)uiDatePicker;

-(UIDatePicker*)uiDatePicker;

-(NSDate*)date;

-(void)setDate:(NSDate*)date;

-(void)setDate:(NSString*)date withFormat:(NSString*)format;

@end
