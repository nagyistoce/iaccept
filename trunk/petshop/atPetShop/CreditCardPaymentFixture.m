//
//  CreditCardPaymentFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "CreditCardPaymentFixture.h"
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAPickerOperator.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IATextFieldOperator.h>
#import <Framework-iAccept/IANavigationBarOperator.h>
#import "ETCreditCardPaymentViewController.h"
#import <Framework-iAccept/IADatePickerOperator.h>
#import <Framework-iAccept/IAButtonOperator.h>
#import <Framework-iAccept/IASliderOperator.h>

@implementation CreditCardPaymentFixture

- (IAViewOperator *)getCreditCardPaymentScreen {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    
    NSArray* views = [detailOperator searchForViewsDelegatingToClass:[ETCreditCardPaymentViewController class]];
    IAViewOperator* paymentViewOperator = [views objectAtIndex:0];
    return paymentViewOperator;
}

-(void)iSelectVisaCardType {    
    NSArray* titles = [NSArray arrayWithObjects:@"Visa",@"MasterCard",@"Discover", nil];
    
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IAPickerOperator* operator = [paymentViewOperator searchForPickerWithTitles:titles];
    
    [operator selectRowNamed:@"Visa" inColumn:0];
}

-(IAThenResult*)theCardNumberTextFieldContains4 {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    IATextFieldOperator* operator = [detailOperator searchForTextFieldWithText:@"4"];
    
    if (!operator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected credit card number field to contains 4."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
} 

-(IAThenResult*)theCardNumberTextFieldContainsFour {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    IATextFieldOperator* operator = [detailOperator searchForTextFieldWithText:@"4"];
    
    if (!operator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected credit card number field to contains 4."];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
} 

-(void)iEnterAValidCreditCardNumber {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    [properties setObject:[UITextField class] forKey:@"class"]; 
    [properties setObject:@"4" forKey:@"text"]; 
    IATextFieldOperator* textFieldOperator = (IATextFieldOperator*)[paymentViewOperator searchForViewWithPropertiesValues:properties];
    
    [textFieldOperator setText:@"4233876635473782"];
}

-(IAThenResult*)theCreditCardNumberFormatted {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    [properties setObject:[UITextField class] forKey:@"class"]; 
    [properties setObject:[NSNumber numberWithInt:2] forKey:@"tag"];
    IATextFieldOperator* textFieldOperator = (IATextFieldOperator*)[paymentViewOperator searchForViewWithPropertiesValues:properties];
    
    
    if (![[textFieldOperator text] isEqualToString:@"4233 8766 3547 3782"]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected credit card number field to contains '4233 8766 3547 3782'"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iEnterAnInvalidCreditCardNumber {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];

    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    [properties setObject:[UITextField class] forKey:@"class"]; 
    [properties setObject:[NSNumber numberWithInt:2] forKey:@"tag"];
    IATextFieldOperator* textFieldOperator = (IATextFieldOperator*)[paymentViewOperator searchForViewWithPropertiesValues:properties];
    
    [textFieldOperator setText:@"4233"];
}

-(IAThenResult*)theCreditCardNumberTextFieldBackgroundRed {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    
    [properties setObject:[UITextField class] forKey:@"class"]; 
    [properties setObject:[NSNumber numberWithInt:2] forKey:@"tag"];
    [properties setObject:[UIColor redColor] forKey:@"backgroundColor"];
    IATextFieldOperator* textFieldOperator = (IATextFieldOperator*)[paymentViewOperator searchForViewWithPropertiesValues:properties];
    
    if (!textFieldOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected credit card number field to have a red background"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(void)iEnterAValidExpirationDate {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    [properties setObject:[UIDatePicker class] forKey:@"class"]; 
    [properties setObject:[NSNumber numberWithInt:3] forKey:@"tag"];
    IADatePickerOperator* datePickerOp = (IADatePickerOperator*)[paymentViewOperator searchForViewWithPropertiesValues:properties];
    
    [datePickerOp setDate:@"2013-06-01" withFormat:@"yyyy-MM-dd"];
}

-(void)iEnterADepositOfFiveHundred {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IASliderOperator* slider = (IASliderOperator*)[paymentViewOperator searchForViewOfClass:[UISlider class]];
    
    [slider setValue:500];
}

-(IAThenResult*)theDepositIsFiveHundred {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IASliderOperator* slider = (IASliderOperator*)[paymentViewOperator searchForViewOfClass:[UISlider class]];
    IALabelOperator* depositLabel = (IALabelOperator*)[paymentViewOperator searchForLabelWithText:@"500"];
    
    if (!slider || !depositLabel || [slider value] != 500) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a deposit of 500"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}


-(IAThenResult*)theExpirationDateShowing {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IADatePickerOperator* datePickerOp = (IADatePickerOperator*)[paymentViewOperator searchForDatePickerWithDate:@"2013-06-01" withFormat:@"yyyy-MM-dd"];

    if (!datePickerOp) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected a valid date in date picker"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

-(IAThenResult*)payButtonDisabled {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IAButtonOperator* payButton = [paymentViewOperator searchForButtonWithText:@"Pay" forState:UIControlStateNormal];
    
    if (!payButton || [payButton isEnabled]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected pay button to be disabled"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }

}

-(IAThenResult*)payButtonEnabled {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IAButtonOperator* payButton = [paymentViewOperator searchForButtonWithText:@"Pay" forState:UIControlStateNormal];
    
    if (!payButton || ![payButton isEnabled]) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected pay button to be enabled"];
    } else {
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
    
}

-(void) iTouchTheNavigationBarBackButton {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailViewOperator = [splitOperator rootViewOfDetailViewOperator];
    IANavigationBarOperator* navBar = [IANavigationBarOperator navigationBarOperatorForUINavigationBar:(UINavigationBar*)[[detailViewOperator searchForViewOfClass:[UINavigationBar class]] uiView]];
    
    [navBar touchLeftBarButton];
}

-(void) iTouchThePayButton {
    IAViewOperator* paymentViewOperator = [self getCreditCardPaymentScreen];
    IAButtonOperator* payButton = [paymentViewOperator searchForButtonWithText:@"Pay" forState:UIControlStateNormal];
    
    [payButton touch];
}


@end
