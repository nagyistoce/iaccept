//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAPickerOperator.h"

@implementation IAPickerOperator

+(IAPickerOperator*) pickerOperatorForUIPickerView:(UIPickerView*)uiPickerView {
    IAPickerOperator* operator = [[[IAPickerOperator alloc] init] autorelease];
    [operator setUiView:uiPickerView];
    return operator; 
}

-(UIPickerView*)uiPickerView {
    return (UIPickerView*)self.uiView;
}

-(void)selectRow:(int)row inColumn:(int)column {
    [self.uiPickerView selectRow:row inComponent:column animated:NO];
    [[self.uiPickerView delegate] pickerView:self.uiPickerView didSelectRow:row inComponent:column];
}

-(void)selectRowNamed:(NSString*)name inColumn:(int)column {
    id<UIPickerViewDataSource> datasouce = [self.uiPickerView dataSource];
    id<UIPickerViewDelegate> delegate = [self.uiPickerView delegate];
    
    int rowCount = [datasouce pickerView:self.uiPickerView numberOfRowsInComponent:column];
    for (int j=0;j<rowCount;j++) {
        NSString* currentName = [delegate pickerView:self.uiPickerView titleForRow:j forComponent:column];
        if ([name isEqualToString:currentName]) {
            [self selectRow:j inColumn:column];
            break;
        }
    }
    
}

-(BOOL)containsARowNamed:(NSString*)name {
    id<UIPickerViewDataSource> datasouce = [self.uiPickerView dataSource];
    id<UIPickerViewDelegate> delegate = [self.uiPickerView delegate];
    
    int componentCount = [datasouce numberOfComponentsInPickerView:self.uiPickerView];
    
    for (int i=0;i<componentCount;i++) {
        int rowCount = [datasouce pickerView:self.uiPickerView numberOfRowsInComponent:i];
        for (int j=0;j<rowCount;j++) {
            NSString* currentName = [delegate pickerView:self.uiPickerView titleForRow:j forComponent:i];
            if ([name isEqualToString:currentName]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
