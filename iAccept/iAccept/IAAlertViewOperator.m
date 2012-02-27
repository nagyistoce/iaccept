//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAAlertViewOperator.h"
#import "IAButtonOperator.h"
#import "IAPropertiesSearchParameters.h"

@implementation IAAlertViewOperator

+(IAAlertViewOperator*) alertViewOperator {
    
    NSArray* windows = [[UIApplication sharedApplication] windows];
       
    for (UIWindow* window in windows) {
        NSMutableDictionary* properties = [NSMutableDictionary dictionaryWithObject:[UIAlertView class] forKey:@"class"];
        IAPropertiesSearchParameters* parameters = [IAPropertiesSearchParameters initWithPropertiesToMatch:properties];
        NSMutableArray* viewsFound = [[[NSMutableArray alloc] init] autorelease];
        [IAViewOperator findViewsWithSearchParameters:parameters inSubviews:[window subviews] returnInArray:viewsFound toDepth:9999];
        
        if ([viewsFound count] == 1) {
            return [viewsFound objectAtIndex:0];
        }
    }
    return nil;
}

+(IAAlertViewOperator*) alertViewOperatorForUIAlertView:(UIAlertView*)uiAlertView {
    IAAlertViewOperator* operator = [[IAAlertViewOperator alloc] init];
    [operator setUiView:uiAlertView];
    return [operator autorelease];
}

-(UIAlertView*)uiAlertView {
    return (UIAlertView*)self.uiView;
}

-(NSString*)title {
    return [self.uiAlertView title];
}

-(NSString*)message {
    return [self.uiAlertView message];
}

-(void)touchCancelButton {
    UIAlertView* view = self.uiAlertView;
    
    int index = [view cancelButtonIndex];
    NSString* title = [view buttonTitleAtIndex:index];
    
    IAButtonOperator* cancelButton = [self searchForButtonWithText:title forState:UIControlStateNormal];
    
    [cancelButton touch];
}

@end
