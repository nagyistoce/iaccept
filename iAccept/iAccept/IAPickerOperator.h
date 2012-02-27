//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IAViewOperator.h>

@interface IAPickerOperator : IAViewOperator

+(IAPickerOperator*) pickerOperatorForUIPickerView:(UIPickerView*)uiPickerView;

-(UIPickerView*)uiPickerView;

-(void)selectRow:(int)row inColumn:(int)column;

-(void)selectRowNamed:(NSString*)name inColumn:(int)column;

-(BOOL)containsARowNamed:(NSString*)name;

@end
