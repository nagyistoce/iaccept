//
//  AnimalWelfareBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "AnimalWelfareBehaviors.h"

@implementation AnimalWelfareBehaviors

-(void) testSendWelfare {
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch animal welfare on menu view);
    IAThen(the main view displays animal welfare);
    
    IAWhen(i touch send by email on animal welfare);
    IAThen(alert popup shows sent by email);
    
    IAWhen(i dismiss alert popup);
    IAThen(the main view displays animal welfare);
}

-(void) testReadWelfare {
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch animal welfare on menu view);
    IAThen(the main view displays animal welfare);
    
    IAWhen(i touch the page control middle dot on animal welfare);
    IAThen(welfare second page is showing);
    
    IAWhen(i drag to see page three);
    IAThen(welfare third page is showing);
}

@end
