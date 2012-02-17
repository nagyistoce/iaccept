//
//  ShoppingCartViewBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ShoppingCartViewBehaviors.h"

@implementation ShoppingCartViewBehaviors

-(void)testCheckout {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in portrait);
    
    IAWhen(i touch the promo button on menu view);
    IAWhen(i touch the more tab button on promotions);
    IAThen(the main view displays the promotions);
    IAWhen(i touch the buy now button for the cockatoo on promotions);
   
    IAWhen(i touch the shopping cart button on menu view);
    IAWhen(i touch the checkout button on shopping cart);
    IAWhen(i touch credit card payment option on payment);
    IAThen(the main view displays the credit card payment);
    
    IAWhen(i touch the navigation bar back button on credit card payment);
    IAThen(the main view displays the shopping cart);
}

-(void)testDelete {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the promo button on menu view);
    IAWhen(i touch the more tab button on promotions);
    IAThen(the main view displays the promotions);
    IAWhen(i touch the buy now button for the cockatoo on promotions);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAThen(the shopping cart contains the cockatoo);
    
    IAWhen(i touch the cockatoo switch on shopping cart);
    IAWhen(i touch the delete button on shopping cart);
    
    IAThen(the shopping cart does not contains the cockatoo);
}

@end
