//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAControllerOperator.h>
#import <UIKit/UIKit.h>

@protocol IAViewSearchParameters;
@class IAButtonOperator;
@class IALabelOperator;
@class IANavigationBarOperator;
@class IAPickerOperator;
@class IATextFieldOperator;
@class IADatePickerOperator;
@class IATextViewOperator;
@class IAStepperOperator;
@class IASegmentedControlOperator;
@class IAWebViewOperator;
@class IAActivityIndicatorOperator;
@class IAAlertViewOperator;
@class IAToolbarOperator;
@class IAPageControlOperator;
@class IAScrollViewOperator;

@interface IAViewOperator : NSObject

@property(strong, nonatomic) UIView* uiView;

+(IAViewOperator*) viewOperatorForUIView:(UIView*)view;

+(IAViewOperator*) viewOperatorForAppDelegateRootView:(id<UIApplicationDelegate>)delegate;

+(IAViewOperator*)findViewWithSearchParameters:(NSObject<IAViewSearchParameters>*)parameters inSubviews:(NSArray *)subviews toDepth:(int)depth;

+(void)findViewsWithSearchParameters:(NSObject<IAViewSearchParameters>*)parameters inSubviews:(NSArray *)subviews returnInArray:(NSMutableArray*)viewsFound toDepth:(int)depth;

-(BOOL)isHidden;

-(int)tag;


-(IAButtonOperator*) searchForButtonWithText:(NSString*)text forState:(UIControlState)state;

-(IAButtonOperator*) searchForButtonWithImage:(UIImage*)image forState:(UIControlState)state;

-(IAViewOperator*) searchForViewOfClass:(Class)clazz;

-(IALabelOperator*) searchForLabelWithText:(NSString*)text;

-(IATextFieldOperator*) searchForTextFieldWithText:(NSString*)text;

-(IATextViewOperator*) searchForTextViewContainingText:(NSString*)text;

-(IANavigationBarOperator*) searchForNavigationBarWithTitle:(NSString*)title;

-(IAPickerOperator*) searchForPickerWithTitles:(NSArray*)titles;

-(IADatePickerOperator*) searchForDatePickerWithDate:(NSString*)format withFormat:(NSString*)date;

-(IAStepperOperator*) searchForStepperWithValue:(double)value;

-(NSArray*)searchForViewsDelegatingTo:(id)delegate;

-(NSArray*)searchForViewsDelegatingToClass:(Class)clazz;

-(IAViewOperator*)searchForViewWithPropertiesValues:(NSDictionary*)properties;

-(IAViewOperator*)searchForImage:(UIImage*)image;

-(NSArray*)searchForViewsWithPropertiesValues:(NSDictionary*)properties;

-(IAViewOperator*)searchForViewWithTag:(int)tag;

-(IASegmentedControlOperator*) searchForSegmentedControlContainingTitles:(NSArray*)titles;

-(IAWebViewOperator*) searchForWebView;

-(IAActivityIndicatorOperator*) searchForActivityIndicator;

-(IAToolbarOperator*) searchForToolbar;

-(IAPageControlOperator*)searchForPageControl;

-(IAScrollViewOperator*) searchForScrollView;




-(IAButtonOperator*) searchForButtonWithText:(NSString*)text forState:(UIControlState)state toDepth:(int)depth;

-(IAButtonOperator*) searchForButtonWithImage:(UIImage*)image forState:(UIControlState)state toDepth:(int)depth;

-(IAViewOperator*) searchForViewOfClass:(Class)clazz toDepth:(int)depth;

-(IALabelOperator*) searchForLabelWithText:(NSString*)text toDepth:(int)depth;

-(IATextFieldOperator*) searchForTextFieldWithText:(NSString*)text toDepth:(int)depth;

-(IATextViewOperator*) searchForTextViewContainingText:(NSString*)text toDepth:(int)depth;

-(IANavigationBarOperator*) searchForNavigationBarWithTitle:(NSString*)title toDepth:(int)depth;

-(IAPickerOperator*) searchForPickerWithTitles:(NSArray*)titles toDepth:(int)depth;

-(IADatePickerOperator*) searchForDatePickerWithDate:(NSString*)format withFormat:(NSString*)date toDepth:(int)depth;

-(IAStepperOperator*) searchForStepperWithValue:(double)value toDepth:(int)depth;

-(NSArray*)searchForViewsDelegatingTo:(id)delegate toDepth:(int)depth;

-(NSArray*)searchForViewsDelegatingToClass:(Class)clazz toDepth:(int)depth;

-(IAViewOperator*)searchForViewWithPropertiesValues:(NSDictionary*)properties toDepth:(int)depth;

-(IAViewOperator*)searchForImage:(UIImage*)image toDepth:(int)depth;

-(NSArray*)searchForViewsWithPropertiesValues:(NSDictionary*)properties toDepth:(int)depth;

-(IAViewOperator*)searchForViewWithTag:(int)tag toDepth:(int)depth;

-(IASegmentedControlOperator*) searchForSegmentedControlContainingTitles:(NSArray*)titles toDepth:(int)depth;

-(IAControllerOperator*) searchForTopViewControllerOfClass:(Class)clazz;

-(IAWebViewOperator*) searchForWebViewToDepth:(int)depth;

-(IAActivityIndicatorOperator*) searchForActivityIndicatorToDepth:(int)depth;

-(IAToolbarOperator*) searchForToolbarToDepth:(int)depth;

-(IAPageControlOperator*)searchForPageControlToDepth:(int)depth;

-(IAScrollViewOperator*) searchForScrollViewToDepth:(int)depth;

@end
