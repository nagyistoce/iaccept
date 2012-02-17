//
//  DisclaimerBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "DisclaimerBehaviors.h"

@implementation DisclaimerBehaviors

-(void) testDisclaimerReading {
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the disclaimer on menu view);
    IAThen(the main view displays the disclaimer);
    
    IAWhen(i scroll to the bottom of the first page on disclaimer);
    IAThen(i see the bottom of the page);
    
    IAWhen(i scroll to the top of the first page on disclaimer);
    IAThen(i see the top of the page);
    
    IAWhen(show next page on disclaimer);
    IAThen(the main view displays page two of disclaimer);
    
    IAWhen(show next page on disclaimer);
    IAThen(the main view displays page three of disclaimer);
    
    IAWhen(show previous page on disclaimer);
    IAThen(the main view displays page two of disclaimer);
    
    IAWhen(show previous page on disclaimer);
    IAThen(the main view displays page one of disclaimer);
    
}

@end
