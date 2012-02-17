//
//  PolicyBehaviors.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "PolicyBehaviors.h"

@implementation PolicyBehaviors

-(void) testPolicyReading {
    IAGiven(i launched the petshop in landscape);
    
    IAWhen(i touch the policy on menu view);
    IAThen(the main view displays the policy);
    
    IAWhen(show next page on policy);
    IAThen(the main view displays page tree of policy);
    IAThen(the main view displays page four of policy);
    
    IAWhen(show previous page on policy);
    IAThen(the main view displays page one of policy);
    IAThen(the main view displays page two of policy);
}

@end
