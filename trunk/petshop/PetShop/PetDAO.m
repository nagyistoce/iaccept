//
//  PetDAO.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "PetDAO.h"
#import "DataAccess.h"

@interface PetDAO() {  
}
+ (NSFetchedResultsController *)entities:(NSString*)entityName forPredicate:(NSPredicate*)predicate sortedBy:(NSString*)sortKey forDelegate:(id<NSFetchedResultsControllerDelegate>) delegate;
+ (NSFetchedResultsController *)entities:(NSString*)entityName forKey:(NSString*)key equals:(NSString*)value sortedBy:(NSString*)sortKey forDelegate:(id<NSFetchedResultsControllerDelegate>) delegate;
+ (NSFetchedResultsController *)petsOfKind:(NSString*)kind sortedBy:(NSString*)key forDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
@end

@implementation PetDAO

+ (Pet *) createPet:(NSString*)kind named:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
    Pet* pet = [NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:[[DataAccess instance] managedObjectContext]];
    [pet setBirth:birth];
    [pet setName:name];
    [pet setRace:race];
    [pet setColor:color];
    [pet setKind:kind];
    [pet setPhoto:photo];
    [pet setPrice:price];
    [pet setSpecialPrice:specialPrice];
    return pet;
}

+ (Pet *) createDogNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
    return [self createPet:@"dog" named:name born:birth ofRace:race colored:color withPhoto:photo priced:price specialPriced:specialPrice];
}

+ (Pet *) createCatNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
    return [self createPet:@"cat" named:name born:birth ofRace:race colored:color withPhoto:photo priced:price specialPriced:specialPrice];
}

+ (Pet *) createFishNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
    return [self createPet:@"fish" named:name born:birth ofRace:race colored:color withPhoto:photo priced:price specialPriced:specialPrice];
}

+ (Pet *) createReptileNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
   return [self createPet:@"reptile" named:name born:birth ofRace:race colored:color withPhoto:photo priced:price specialPriced:specialPrice];
}

+ (Pet *) createBirdNamed:(NSString*)name born:(NSDate*)birth ofRace:(NSString*)race colored:(NSString*)color withPhoto:(UIImage*)photo priced:(NSNumber*)price specialPriced:(NSNumber*)specialPrice{
    return [self createPet:@"bird" named:name born:birth ofRace:race colored:color withPhoto:photo priced:price specialPriced:specialPrice];
}

+(void) addPetToShoppingCart:(Pet*)pet {
    if (pet) {
        ShoppingCart* shoppingCart = [self shoppingCart];
        [shoppingCart addPetsObject:pet];
        [[DataAccess instance] saveContext];
    }
}

+(void)removePetFromChoppingCart:(Pet*)pet {
    if (pet) {
        ShoppingCart* shoppingCart = [self shoppingCart];
        [shoppingCart removePetsObject:pet];
        [[DataAccess instance] saveContext];
    }
}

+ (NSArray *) petsInArray {
    NSManagedObjectContext* context = [[DataAccess instance] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"kind" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error = nil;
    return [context executeFetchRequest:fetchRequest error:&error];    
}


+ (NSFetchedResultsController *)dogsForDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    return [self entities:@"Pet" forKey:@"kind" equals:@"dog" sortedBy:@"race" forDelegate:delegate];
}

+ (NSFetchedResultsController *)catsForDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
        return [self entities:@"Pet" forKey:@"kind" equals:@"cat" sortedBy:@"race" forDelegate:delegate];
}

+ (NSFetchedResultsController *)fishsForDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    return [self entities:@"Pet" forKey:@"kind" equals:@"fish" sortedBy:@"race" forDelegate:delegate];
}

+ (NSFetchedResultsController *)reptilesForDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    return [self entities:@"Pet" forKey:@"kind" equals:@"reptile" sortedBy:@"race" forDelegate:delegate];
}

+ (NSFetchedResultsController *)birdsForDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    return [self entities:@"Pet" forKey:@"kind" equals:@"bird" sortedBy:@"race" forDelegate:delegate];
}

+ (NSFetchedResultsController *)petsOfKind:(NSString*)kind {
    return [self petsOfKind:kind sortedBy:@"race" forDelegate:nil];
}

+ (NSFetchedResultsController *)petsOfKind:(NSString*)kind sortedBy:(NSString*)key forDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    return [self entities:@"Pet" forKey:@"kind" equals:kind sortedBy:@"race" forDelegate:delegate];
}

+ (ShoppingCart *)shoppingCart {
    NSManagedObjectContext* context = [[DataAccess instance] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoppingCart" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    NSError* error = nil;
    NSArray* shoppingCarts = [context executeFetchRequest:fetchRequest error:&error]; 
    if ([shoppingCarts count] != 0) {
        return [shoppingCarts objectAtIndex:0];
    }
    return nil;
}

+(Pet*)petNamed:(NSString*)name {
    NSManagedObjectContext* context = [[DataAccess instance] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:1];
    
    NSError* error = nil;
    NSArray* pets = [context executeFetchRequest:fetchRequest error:&error]; 
    if ([pets count] != 0) {
        return [pets objectAtIndex:0];
    }
    return nil;
}

+ (NSFetchedResultsController *)petsInPromotion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"specialPrice != 0 AND cart == nil"];
    return [self entities:@"Pet" forPredicate:predicate sortedBy:@"kind" forDelegate:nil];
}

+ (NSFetchedResultsController *)dogsInPromotion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"specialPrice != 0 AND cart == nil AND kind == 'dog'"];
    return [self entities:@"Pet" forPredicate:predicate sortedBy:@"kind" forDelegate:nil];
}

+ (NSFetchedResultsController *)catsInPromotion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"specialPrice != 0 AND cart == nil AND kind == 'cat'"];
    return [self entities:@"Pet" forPredicate:predicate sortedBy:@"kind" forDelegate:nil];
}

+ (NSFetchedResultsController *)otherPetsInPromotion {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"specialPrice != 0 AND cart == nil AND kind != 'dog' AND kind != 'cat'"];
    return [self entities:@"Pet" forPredicate:predicate sortedBy:@"kind" forDelegate:nil];
}


+ (NSFetchedResultsController *)entities:(NSString*)entityName forKey:(NSString*)key equals:(NSString*)value sortedBy:(NSString*)sortKey forDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K LIKE[c] %@ AND cart == nil)", key, value];
    return [self entities:entityName forPredicate:predicate sortedBy:(NSString*)sortKey forDelegate:delegate];
}

+ (NSFetchedResultsController *)entities:(NSString*)entityName forPredicate:(NSPredicate*)predicate sortedBy:(NSString*)sortKey forDelegate:(id<NSFetchedResultsControllerDelegate>) delegate {
    NSManagedObjectContext* context = [[DataAccess instance] managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];

    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController* fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:@"kind" cacheName:nil];
    [fetchedResultsController setDelegate:delegate];
    
    return fetchedResultsController;
}

@end
