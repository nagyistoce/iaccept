//
//  MainNavigationViewBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "MainNavigationViewBehaviors.h"


@implementation MainNavigationViewBehaviors

-(void)testChooseDogsLandscape {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
}

-(void)testChooseCatsLandscape {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the cat menu item on menu view);
    IAThen(the main view displays the cat list);
}

-(void)testChooseDogsPortrait {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in portrait);
    
    IAWhen(i touch the shop button);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
}

-(void)testChooseCatsPortrait {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in portrait);
    
    IAWhen(i touch the shop button);
    IAWhen(i touch the cat menu item on menu view);
    IAThen(the main view displays the cat list);
}

-(void)testOpenShoppingCart {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the promo button on menu view);
    IAWhen(i touch the more tab button on promotions);
    IAThen(the main view displays the promotions);
    IAWhen(i touch the buy now button for the cockatoo on promotions);
    
    IAWhen(i touch the shopping cart button on menu view);
    IAThen(the main view displays the shopping cart);
    IAThen(the shopping cart contains the cockatoo);
}

-(void)testOpenPromo {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the promo button on menu view);
    IAThen(the main view displays the promotions);
}

@end