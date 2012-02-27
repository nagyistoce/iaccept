//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAViewOperator.h"

#import "IAViewSearchParameters.h"
#import "IAButtonTextSearchParameters.h"
#import "IAButtonImageSearchParameters.h"
#import "IAViewClassSearchParameters.h"
#import "IALabelTextSearchParameters.h"
#import "IANavigationBarTitleSearchParameters.h"
#import "IAPickerViewSearchParameters.h"
#import "IATextFieldTextSearchParameters.h"
#import "IADelegateSearchParameters.h"
#import "IADelegateClassSearchParameters.h"
#import "IAPropertiesSearchParameters.h"
#import "IADatePickerDateSearchParameters.h"
#import "IAImageSearchParameters.h"
#import "IATagSearchParameters.h"
#import "IAUIViewHierarchyWalker.h"
#import "IAControllerOperatorFactory.h"
#import "IATextViewTextSearchParameters.h"
#import "IAStepperValueSearchParameters.h"
#import "IASegmentedControlSegmentSearchParameters.h"

int const MAX_DEPTH = 9999;

@implementation IAViewOperator

@synthesize uiView = _uiView;

+(IAViewOperator*) viewOperatorForUIView:(UIView*)view {
    IAViewOperator* operator = [[[IAViewOperator alloc] init] autorelease];
    [operator setUiView:view];
    return operator;
}

+(IAViewOperator*) viewOperatorForAppDelegateRootView:(id<UIApplicationDelegate>)delegate {
    return [self viewOperatorForUIView:[[[delegate window] rootViewController] view]];
}

-(BOOL)isHidden {
    return [[self uiView] isHidden];
}

-(int)tag {
    return [[self uiView] tag];
}

+ (IAViewOperator*)findViewWithSearchParameters:(NSObject<IAViewSearchParameters>*)parameters inSubviews:(NSArray *)subviews toDepth:(int)depth {
    IAViewOperator* operator = nil;
    for (UIView* subview in subviews) {
        if ([parameters keepThisView:subview]) {
            operator = [parameters viewOperator];
            break;
        }
        if (depth != 0) {
            operator = [self findViewWithSearchParameters:parameters inSubviews:[subview subviews] toDepth:depth--];
            if (operator != nil) {
                break;
            }
        }
        
    }
    return operator;
}

+ (void)findViewsWithSearchParameters:(NSObject<IAViewSearchParameters>*)parameters inSubviews:(NSArray *)subviews returnInArray:(NSMutableArray*)viewsFound toDepth:(int)depth {

    for (UIView* subview in subviews) {
        if ([parameters keepThisView:subview]) {
            IAViewOperator* operator = [parameters viewOperator];
            [viewsFound addObject:operator];
        }
        if (depth != 0) {
            [self findViewsWithSearchParameters:parameters inSubviews:[subview subviews] returnInArray:viewsFound toDepth:depth--];
        }
    }
}

-(IAButtonOperator*) searchForButtonWithText:(NSString*)text forState:(UIControlState)state toDepth:(int)depth{
    IAButtonTextSearchParameters* parameters = [IAButtonTextSearchParameters initWithText:text andState:state];
    return (IAButtonOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAButtonOperator*) searchForButtonWithText:(NSString*)text forState:(UIControlState)state {
    return [self searchForButtonWithText:text forState:state toDepth:MAX_DEPTH];
}

-(IAButtonOperator*) searchForButtonWithImage:(UIImage*)image forState:(UIControlState)state toDepth:(int)depth {
    IAButtonImageSearchParameters* parameters = [IAButtonImageSearchParameters initWithImage:image andState:state];
    return (IAButtonOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAButtonOperator*) searchForButtonWithImage:(UIImage*)image forState:(UIControlState)state {
    return [self searchForButtonWithImage:image forState:state toDepth:MAX_DEPTH];
}

-(IAViewOperator*) searchForViewOfClass:(Class)clazz toDepth:(int)depth {
    IAViewClassSearchParameters* parameters = [IAViewClassSearchParameters initWithClass:clazz];
    return [IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAViewOperator*) searchForViewOfClass:(Class)clazz {
    return [self searchForViewOfClass:clazz toDepth:MAX_DEPTH];
}

-(IALabelOperator*) searchForLabelWithText:(NSString*)text toDepth:(int)depth {
    IALabelTextSearchParameters* parameters = [IALabelTextSearchParameters initWithText:text];
    return (IALabelOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IALabelOperator*) searchForLabelWithText:(NSString*)text {
    return [self searchForLabelWithText:text toDepth:MAX_DEPTH];
}

-(IATextFieldOperator*) searchForTextFieldWithText:(NSString*)text toDepth:(int)depth {
    IATextFieldTextSearchParameters* parameters = [IATextFieldTextSearchParameters initWithText:text];
    return (IATextFieldOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];    
}

-(IATextFieldOperator*) searchForTextFieldWithText:(NSString*)text {
    return [self searchForTextFieldWithText:text toDepth:MAX_DEPTH];
}

-(IATextViewOperator*) searchForTextViewContainingText:(NSString*)text toDepth:(int)depth {
    IATextViewTextSearchParameters* parameters = [IATextViewTextSearchParameters initWithText:text];
    return (IATextViewOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth]; 
}

-(IATextViewOperator*) searchForTextViewContainingText:(NSString*)text {
    return [self searchForTextViewContainingText:text toDepth:MAX_DEPTH];
}

-(IANavigationBarOperator*) searchForNavigationBarWithTitle:(NSString*)title toDepth:(int)depth {
    IANavigationBarTitleSearchParameters* parameters = [IANavigationBarTitleSearchParameters initWithTitle:title];
    return (IANavigationBarOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IANavigationBarOperator*) searchForNavigationBarWithTitle:(NSString*)title {
    return [self searchForNavigationBarWithTitle:title toDepth:(int)MAX_DEPTH];
}

-(IAPickerOperator*) searchForPickerWithTitles:(NSArray*)titles toDepth:(int)depth {    
    IAPickerViewSearchParameters* parameters = [IAPickerViewSearchParameters initWithTitles:titles];
    return (IAPickerOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAPickerOperator*) searchForPickerWithTitles:(NSArray*)titles {
    return [self searchForPickerWithTitles:titles toDepth:MAX_DEPTH];
}

-(IADatePickerOperator*) searchForDatePickerWithDate:(NSString*)date withFormat:(NSString*)format toDepth:(int)depth {    
    IADatePickerDateSearchParameters* parameters = [IADatePickerDateSearchParameters initWithFormat:format forDate:date];
    return (IADatePickerOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IADatePickerOperator*) searchForDatePickerWithDate:(NSString*)date withFormat:(NSString*)format {
    return [self searchForDatePickerWithDate:date withFormat:format toDepth:MAX_DEPTH];
}

-(NSArray*)searchForViewsDelegatingTo:(id)delegate toDepth:(int)depth {
    IADelegateSearchParameters* parameters = [IADelegateSearchParameters initWithDelegate:delegate];
    NSMutableArray* viewsFound = [[[NSMutableArray alloc] init] autorelease];
    [IAViewOperator findViewsWithSearchParameters:parameters inSubviews:[_uiView subviews] returnInArray:viewsFound toDepth:depth];
    return viewsFound;
}

-(NSArray*)searchForViewsDelegatingTo:(id)delegate {
    return [self searchForViewsDelegatingTo:delegate toDepth:MAX_DEPTH];
}

-(NSArray*)searchForViewsDelegatingToClass:(Class)clazz toDepth:(int)depth {
    IADelegateClassSearchParameters* parameters = [IADelegateClassSearchParameters initWithDelegateClass:clazz];
    NSMutableArray* viewsFound = [[[NSMutableArray alloc] init] autorelease];
    [IAViewOperator findViewsWithSearchParameters:parameters inSubviews:[_uiView subviews] returnInArray:viewsFound toDepth:depth];
    return viewsFound;
}

-(NSArray*)searchForViewsDelegatingToClass:(Class)clazz {
    return [self searchForViewsDelegatingToClass:clazz toDepth:MAX_DEPTH];
}

-(IAViewOperator*)searchForViewWithPropertiesValues:(NSDictionary*)properties toDepth:(int)depth {
    IAPropertiesSearchParameters* parameters = [IAPropertiesSearchParameters initWithPropertiesToMatch:properties];
    return [IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAViewOperator*)searchForViewWithPropertiesValues:(NSDictionary*)properties {
    return [self searchForViewWithPropertiesValues:properties toDepth:MAX_DEPTH];
}

-(NSArray*)searchForViewsWithPropertiesValues:(NSDictionary*)properties toDepth:(int)depth {
    IAPropertiesSearchParameters* parameters = [IAPropertiesSearchParameters initWithPropertiesToMatch:properties];
    NSMutableArray* viewsFound = [[[NSMutableArray alloc] init] autorelease];
    [IAViewOperator findViewsWithSearchParameters:parameters inSubviews:[_uiView subviews] returnInArray:viewsFound toDepth:depth];
    return viewsFound;
}

-(NSArray*)searchForViewsWithPropertiesValues:(NSDictionary*)properties {
    return [self searchForViewsWithPropertiesValues:properties toDepth:MAX_DEPTH];
}

-(IAViewOperator*)searchForImage:(UIImage*)image toDepth:(int)depth {
    IAImageSearchParameters* parameters = [IAImageSearchParameters initWithImage:image];
    return [IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth]; 
}

-(IAViewOperator*)searchForImage:(UIImage*)image {
    return [self searchForImage:image toDepth:MAX_DEPTH];
}

-(IAViewOperator*)searchForViewWithTag:(int)tag toDepth:(int)depth {
    IATagSearchParameters* parameters = [IATagSearchParameters initWithTag:tag];
    return [IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];
}

-(IAViewOperator*)searchForViewWithTag:(int)tag {
    return [self searchForViewWithTag:tag toDepth:MAX_DEPTH];
}

-(IAStepperOperator*) searchForStepperWithValue:(double)value toDepth:(int)depth {
    IAStepperValueSearchParameters* parameters = [IAStepperValueSearchParameters initWithValue:value];
    return (IAStepperOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];    
}

-(IAStepperOperator*) searchForStepperWithValue:(double)value {
    return (IAStepperOperator*)[self searchForStepperWithValue:value toDepth:MAX_DEPTH];  
}

-(IASegmentedControlOperator*) searchForSegmentedControlContainingTitles:(NSArray*)titles toDepth:(int)depth {
    IASegmentedControlSegmentSearchParameters* parameters = [IASegmentedControlSegmentSearchParameters initWithSegmentsTitles:titles];
    return (IASegmentedControlOperator*)[IAViewOperator findViewWithSearchParameters:parameters inSubviews:[_uiView subviews] toDepth:depth];    
}

-(IASegmentedControlOperator*) searchForSegmentedControlContainingTitles:(NSArray*)titles {
    return (IASegmentedControlOperator*)[self searchForSegmentedControlContainingTitles:titles toDepth:MAX_DEPTH];  
}

-(IAWebViewOperator*) searchForWebViewToDepth:(int)depth {
    return (IAWebViewOperator*)[self searchForViewOfClass:[UIWebView class] toDepth:depth];
}

-(IAWebViewOperator*) searchForWebView {
    return (IAWebViewOperator*)[self searchForWebViewToDepth:MAX_DEPTH];
}

-(IAActivityIndicatorOperator*) searchForActivityIndicatorToDepth:(int)depth {
    return (IAActivityIndicatorOperator*)[self searchForViewOfClass:[UIActivityIndicatorView class] toDepth:depth];
}

-(IAActivityIndicatorOperator*) searchForActivityIndicator {
    return (IAActivityIndicatorOperator*)[self searchForActivityIndicatorToDepth:MAX_DEPTH];
}


-(IAToolbarOperator*) searchForToolbarToDepth:(int)depth {
    return (IAToolbarOperator*)[self searchForViewOfClass:[UIToolbar class] toDepth:depth];
}

-(IAToolbarOperator*) searchForToolbar {
    return (IAToolbarOperator*)[self searchForToolbarToDepth:MAX_DEPTH];
}

-(IAPageControlOperator*) searchForPageControl {
    return (IAPageControlOperator*)[self searchForPageControlToDepth:MAX_DEPTH];
}

-(IAPageControlOperator*) searchForPageControlToDepth:(int)depth {
    return (IAPageControlOperator*)[self searchForViewOfClass:[UIPageControl class] toDepth:depth];
}

-(IAScrollViewOperator*) searchForScrollView {
    return (IAScrollViewOperator*)[self searchForScrollViewToDepth:MAX_DEPTH];
}

-(IAScrollViewOperator*) searchForScrollViewToDepth:(int)depth {
    return (IAScrollViewOperator*)[self searchForViewOfClass:[UIScrollView class] toDepth:depth];
}

- (IAControllerOperator*)walkDownUIViewHiearchyToFindController:(UIView *)currentView clazz:(Class)clazz {
    while (currentView != nil) {
        id nextResponder = [currentView nextResponder];
        NSLog(@"Controller %@", [[nextResponder class] description]);
        if ([nextResponder isKindOfClass:clazz]) {
            return [IAControllerOperatorFactory createControllerOperatorForUIViewController:nextResponder];
        }
        currentView = [currentView superview];
    }
    return nil;
}

-(IAControllerOperator*) searchForTopViewControllerOfClass:(Class)clazz {    
    UIView* currentView = [IAUIViewHierarchyWalker findTopChildUIViewFromUIView:[self uiView]];
    return [self walkDownUIViewHiearchyToFindController:currentView clazz:clazz];
}


@end
