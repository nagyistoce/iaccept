//
//  PetListViewBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-24.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PetListViewBehaviors.h"

@implementation PetListViewBehaviors

-(void) testPetInformation {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
    IAThen(the pet list contains a dog named Benji);
    
    IAThen(Benji table cell contains his name breed photo and price);
}

-(void) testSpecialPetInformation {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
    IAThen(the pet list contains a dog named Fido);
    
    IAThen(Fido table cell contains his name breed photo price special price and special tag);
}

-(void) testAddToCartRemovesPetFromList {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
    IAThen(the pet list contains a dog named Fido);
    
    IAWhen(i touch Fidos row);
    IAWhen(i touch the add to cart button);
    IAThen(the pet list does not contains a dog named fido);
}

-(void) testPetListSelectedPetDetailRegular {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
    IAThen(the pet list contains a dog named Benji);
    
    IAWhen(i touch Benjis row);
    
    IAThen(Benjis informations are displayed in the details);
    IAThen(special price and tag are not displayed);
}

-(void) testPetListSelectedPetDetailSpecial {
    IAGiven(i start with an empty shopping cart);
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the dog menu item on menu view);
    IAThen(the main view displays the dog list);
    IAThen(the pet list contains a dog named Fido);
    
    IAWhen(i touch Fidos row);
    
    IAThen(Fidos informations are displayed in the details);
    IAThen(special price and tag are displayed);
}

@end
