//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPickerViewDelegate.h"

@implementation UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"Select a card";
    } else if (row == 1) {
        return @"Visa";
    } else if (row == 2) {
        return @"MasterCard";
    } else if (row == 3) {
        return @"Discover";
    } else {
        return @"Other";
    }
}


@end
