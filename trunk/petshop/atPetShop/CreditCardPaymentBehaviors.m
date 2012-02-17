//
//  CreditCardPaymentBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-18.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "CreditCardPaymentBehaviors.h"

@implementation CreditCardPaymentBehaviors


-(void)testEnterCreditCardNumber {
    IAGiven(i start with pets in shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAWhen(i touch the checkout button on shopping cart);
    IAWhen(i touch credit card payment option on payment);
    IAThen(the main view displays the credit card payment);
    
    IAWhen(i select visa card type on credit card payment);
    IAThen(the card number text field contains four);
    
    IAWhen(i enter a valid credit card number);
    IAThen(the credit card number formatted);
    
    IAWhen(i enter an invalid credit card number);
    IAThen(the credit card number text field background red);
}


-(void)testPayButtonEnabledWithValidValues {
    IAGiven(i start with pets in shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAWhen(i touch the checkout button on shopping cart);
    IAWhen(i touch credit card payment option on payment);
    IAThen(the main view displays the credit card payment);
    IAThen(the credit card payment pay button disabled);
    
    IAWhen(i enter a deposit of five hundred);
    IAWhen(i select visa card type on credit card payment);
    IAWhen(i enter a valid credit card number);
    IAWhen(i enter a valid expiration date);
    
    IAThen(the deposit is five hundred);
    IAThen(the credit card payment pay button enabled);
}

-(void)testTouchPayButtonWhenEnabledGoesToThanksScreen {
    IAGiven(i start with pets in shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAWhen(i touch the checkout button on shopping cart);
    IAWhen(i touch credit card payment option on payment);
    IAThen(the main view displays the credit card payment);
    IAThen(the credit card payment pay button disabled);
    
    IAWhen(i select visa card type on credit card payment);
    IAWhen(i enter a valid credit card number);
    IAWhen(i enter a valid expiration date);
    
    IAWhen(i touch the pay button);
    IAThen(the main view displays thanks screen);
    IAThen(the thanks screen map shows the shop location);
}

@end