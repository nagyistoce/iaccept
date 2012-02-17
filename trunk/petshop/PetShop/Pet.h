//
//  Pet.h
//  PetShop
//
//  Created by Nicolas Desjardins on 12-01-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShoppingCart;

@interface Pet : NSManagedObject

@property (nonatomic, retain) NSDate * birth;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * race;
@property (nonatomic, retain) NSNumber * specialPrice;
@property (nonatomic, retain) ShoppingCart *cart;

-(NSNumber*) offPercentage;

-(NSString*) age;
@end
