//
//  Pet.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "Pet.h"
#import "ShoppingCart.h"


@implementation Pet

@dynamic birth;
@dynamic color;
@dynamic kind;
@dynamic name;
@dynamic photo;
@dynamic price;
@dynamic race;
@dynamic specialPrice;
@dynamic cart;


-(NSNumber*) offPercentage {
    double off = ([[self price] doubleValue] / [[self specialPrice] doubleValue] - 1) * 100;
    return [NSNumber numberWithDouble:ceil(off)];
}

-(NSString*) age {
    NSDate* currentDate = [[NSDate alloc] init];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:[self birth] toDate:currentDate options:0];
    
    int year = [components year];
    int months = [components month];
    
    if (year > 0) {
        return [NSString stringWithFormat:@"%@ year(s) %@ month(s)", [NSNumber numberWithInt:year] ,[NSNumber numberWithInt:months]];
    } else {
        return [NSString stringWithFormat:@"%@ month(s)", [NSNumber numberWithInt:months]];
        
    }
}
@end
