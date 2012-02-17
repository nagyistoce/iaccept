//
//  ShoppingCart.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-12-20.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pet;

@interface ShoppingCart : NSManagedObject

@property (nonatomic, retain) NSSet *pets;
@end

@interface ShoppingCart (CoreDataGeneratedAccessors)

- (void)addPetsObject:(Pet *)value;
- (void)removePetsObject:(Pet *)value;
- (void)addPets:(NSSet *)values;
- (void)removePets:(NSSet *)values;

@end
