//
//  AlternativePaymentBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-06.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "AlternativePaymentBehaviors.h"

@implementation AlternativePaymentBehaviors

-(void)testSelectPaymentMethodInMore {
    IAGiven(i start with pets in shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAWhen(i touch the checkout button on shopping cart);
    IAWhen(i touch more on payment);
    IAThen(the payment displays the more table);
    
    IAWhen(i select credit note on payment);
    IAThen(the payment displays the alternative payment credit note);
    IAThen(web portal loaded);
    
    IAWhen(i change deposit value with four stepper plus touch);
    IAThen(the deposit is five hundred);
    
    IAWhen(i change deposit value with four stepper minus touch);
    IAThen(the deposit is minimum);
    
    IAWhen(i touch the in shop payment mode);
    IAThen(the in store payment mode is selected);
    
    
    
    IAWhen(i touch the confirm button);
    IAThen(the main view displays thanks screen);
}


@end
