//
//  PetDAO.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"
#import "ShoppingCart.h"

@interface PetDAO : NSObject

+ (Pet *)createDogNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice;
+ (Pet *)createCatNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice;
+ (Pet *)createFishNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice;
+ (Pet *)createReptileNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice;
+ (Pet *)createBirdNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice;

+(void) addPetToShoppingCart:(Pet*)pet;
+(void)removePetFromChoppingCart:(Pet*)pet;

+(Pet*)petNamed:(NSString*)name;

+ (NSArray *)petsInArray;
+ (NSFetchedResultsController *)petsInPromotion;
+ (NSFetchedResultsController *)dogsInPromotion;
+ (NSFetchedResultsController *)catsInPromotion;
+ (NSFetchedResultsController *)otherPetsInPromotion;

+ (ShoppingCart *)shoppingCart;
+ (NSFetchedResultsController *)petsOfKind:(NSString*)kind;
+ (NSFetchedResultsController *)dogsForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)catsForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fishsForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)reptilesForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)birdsForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;

@end
