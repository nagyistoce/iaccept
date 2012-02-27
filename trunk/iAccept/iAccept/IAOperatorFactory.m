//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAOperatorFactory.h"
#import "IAButtonOperator.h"
#import "IATableOperator.h"
#import "IALabelOperator.h"
#import "IANavigationBarOperator.h"
#import "IASwitchOperator.h"
#import "IAPickerOperator.h"
#import "IATextFieldOperator.h"
#import "IADatePickerOperator.h"
#import "IAMapOperator.h"
#import "IASliderOperator.h"
#import "IATabBarOperator.h"
#import "IATextViewOperator.h"
#import "IAStepperOperator.h"
#import "IASegmentedControlOperator.h"
#import "IAWebViewOperator.h"
#import "IAActivityIndicatorOperator.h"
#import "IAAlertViewOperator.h"
#import "IAToolbarOperator.h"
#import "IAPageControlOperator.h"
#import "IAScrollViewOperator.h"

@implementation IAOperatorFactory

+(IAViewOperator*)createOperatorForUIView:(UIView*)uiView {
    
    if ([uiView isKindOfClass:[UIButton class]]) {
        return (IAViewOperator*)[IAButtonOperator buttonOperatorForUIButton:(UIButton*)uiView];
    } else if ([uiView isKindOfClass:[UITableView class]]) {
        return (IAViewOperator*)[IATableOperator tableOperatorForUITableView:(UITableView*)uiView];
    } else if ([uiView isKindOfClass:[UILabel class]]) {
        return (IAViewOperator*)[IALabelOperator labelOperatorForUILabel:(UILabel*)uiView];
    } else if ([uiView isKindOfClass:[UINavigationBar class]]) {
        return (IAViewOperator*)[IANavigationBarOperator navigationBarOperatorForUINavigationBar:(UINavigationBar*)uiView];
    } else if ([uiView isKindOfClass:[UISwitch class]]) {
        return (IAViewOperator*)[IASwitchOperator switchOperatorForUISwitch:(UISwitch*)uiView];
    } else if ([uiView isKindOfClass:[UIPickerView class]]) {
        return (IAViewOperator*)[IAPickerOperator pickerOperatorForUIPickerView:(UIPickerView*)uiView];
    } else if ([uiView isKindOfClass:[UITextField class]]) {
        return (IAViewOperator*)[IATextFieldOperator textFieldOperatorForUITextField:(UITextField*)uiView];
    } else if ([uiView isKindOfClass:[UIDatePicker class]]) { 
        return (IAViewOperator*)[IADatePickerOperator datePickerOperatorForUIDatePicker:(UIDatePicker*)uiView];
    } else if ([uiView isKindOfClass:[MKMapView class]]) { 
        return (IAViewOperator*)[IAMapOperator mapOperatorForMKMapView:(MKMapView*)uiView];
    } else if ([uiView isKindOfClass:[UISlider class]]) { 
        return (IAViewOperator*)[IASliderOperator sliderOperatorForUISlider:(UISlider*)uiView];
    } else if ([uiView isKindOfClass:[UITabBar class]]) { 
        return (IAViewOperator*)[IATabBarOperator tabBarOperatorForUITabBar:(UITabBar*)uiView];
    } else if ([uiView isKindOfClass:[UITextView class]]) { 
        return (IAViewOperator*)[IATextViewOperator textViewOperatorForUITextView:(UITextView*)uiView];
    } else if ([uiView isKindOfClass:[UIStepper class]]) { 
        return (IAViewOperator*)[IAStepperOperator stepperOperatorForUIStepper:(UIStepper*)uiView];
    } else if ([uiView isKindOfClass:[UISegmentedControl class]]) { 
        return (IAViewOperator*)[IASegmentedControlOperator segmentedControlOperatorForUISegmentedControl:(UISegmentedControl*)uiView];
    } else if ([uiView isKindOfClass:[UIWebView class]]) { 
        return (IAViewOperator*)[IAWebViewOperator webViewOperatorForUIWebView:(UIWebView*)uiView];
    } else if ([uiView isKindOfClass:[UIActivityIndicatorView class]]) { 
        return (IAViewOperator*)[IAActivityIndicatorOperator activityIndicatorOperatorForUIActivityIndicatorView:(UIActivityIndicatorView *)uiView];
    } else if ([uiView isKindOfClass:[UIAlertView class]]) { 
        return (IAViewOperator*)[IAAlertViewOperator alertViewOperatorForUIAlertView:(UIAlertView *)uiView];
    } else if ([uiView isKindOfClass:[UIToolbar class]]) { 
        return (IAViewOperator*)[IAToolbarOperator toolbarOperatorForUIToolbar:(UIToolbar *)uiView];
    } else if ([uiView isKindOfClass:[UIPageControl class]]) { 
        return (IAViewOperator*)[IAPageControlOperator pageControlOperatorForUIPageControl:(UIPageControl *)uiView];
    } else if ([uiView isKindOfClass:[UIScrollView class]]) { 
        return (IAViewOperator*)[IAScrollViewOperator scrollViewOperatorForUIScrollView:(UIScrollView *)uiView];
    } else {
        return [IAViewOperator viewOperatorForUIView:uiView];
    }
}

@end
