//
//  DataAccess.h
//  PetShop
//
//  Created by Nicolas Desjardins on 11-10-15.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataAccess : NSObject {
   
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(DataAccess*)instance;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
