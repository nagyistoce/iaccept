//
//  ETAppDelegate.m
//  PetShop
//
//  Created by Nicolas Desjardins on 11-11-18.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "ETAppDelegate.h"
#import "DataAccess.h"
#import "PetDAO.h"
#import "ETMasterViewController.h"
#import "ETDetailViewController.h"
#import "Pet.h"
#import "ETPromoDetailViewController.h"
#import "ShoppingCart.h"

@interface ETAppDelegate() {
@private
}
-(void)initializeData;
@end

@implementation ETAppDelegate

@synthesize window = _window;
@synthesize splitViewController = _splitViewController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    ETMasterViewController *masterViewController = [[ETMasterViewController alloc] initWithNibName:@"ETMasterViewController" bundle:nil];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    masterNavigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    ETPromoDetailViewController *detailViewController = [[ETPromoDetailViewController alloc] initWithNibName:@"ETPromoDetailViewController" bundle:nil];
    UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    detailNavigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    self.splitViewController = [[UISplitViewController alloc] init];
    self.splitViewController.delegate = masterViewController;
    self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
    masterViewController.detailViewController = detailViewController;
    [masterViewController setSplitViewController:self.splitViewController];
    
    self.window.rootViewController = self.splitViewController;

    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[DataAccess instance] saveContext];
}

-(void)emptyShoppingCart {
    ShoppingCart* cart = [PetDAO shoppingCart];
    [cart removePets:[cart pets]];
}

-(void)putPetsInShoppingCart {
    [PetDAO addPetToShoppingCart:[PetDAO petNamed:@"Piggy"]];
    [PetDAO addPetToShoppingCart:[PetDAO petNamed:@"Benji"]];
}

- (void)clearData {
    NSManagedObjectContext* context = [[DataAccess instance] managedObjectContext];
    
    NSArray* itemsToDelete = [PetDAO petsInArray];
    for (NSManagedObject* entity in itemsToDelete) {
        [context deleteObject:entity];
    }
    
    ShoppingCart* shoppingCart = [PetDAO shoppingCart];
    if (shoppingCart) {
        [context deleteObject:shoppingCart];
    }
    
    [[DataAccess instance] saveContext];
}

-(void)initializeData {
    [self clearData];
    
    [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingCart" inManagedObjectContext:[[DataAccess instance] managedObjectContext]];
    
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    [PetDAO createDogNamed:@"Fido" born:[dateFormat dateFromString:@"2009-04-09"] ofRace:@"Golden Retriever" colored:@"Blond" withPhoto:[UIImage imageNamed:@"GoldenRetriever_small.png"] priced:[NSNumber numberWithInt:625] specialPriced:[NSNumber numberWithInt:575]];    
    [PetDAO createDogNamed:@"Bandit" born:[dateFormat dateFromString:@"2011-04-12"] ofRace:@"Doberman Pinscher" colored:@"Black" withPhoto:[UIImage imageNamed:@"European_Dobermann_small.png"] priced:[NSNumber numberWithInt:950] specialPriced:[NSNumber numberWithInt:0]];
    [PetDAO createDogNamed:@"Benji" born:[dateFormat dateFromString:@"2011-06-05"] ofRace:@"Argentine Dogo" colored:@"Gray" withPhoto:[UIImage imageNamed:@"Dogo_small.png"] priced:[NSNumber numberWithInt:710] specialPriced:[NSNumber numberWithInt:0]];
    
    [PetDAO createCatNamed:@"Augustus" born:[dateFormat dateFromString:@"2010-07-21"] ofRace:@"American Bobtail" colored:@"Chocolate" withPhoto:[UIImage imageNamed:@"American_Bobtail_small.png"] priced:[NSNumber numberWithInt:3450] specialPriced:[NSNumber numberWithInt:0]];    
    [PetDAO createCatNamed:@"Chloe" born:[dateFormat dateFromString:@"2011-01-06"] ofRace:@"Balinese" colored:@"Blue" withPhoto:[UIImage imageNamed:@"balinese-cat_small.png"] priced:[NSNumber numberWithInt:1500] specialPriced:[NSNumber numberWithInt:1450]];
    [PetDAO createCatNamed:@"Gizmo" born:[dateFormat dateFromString:@"2011-02-18"] ofRace:@"Chartreux" colored:@"White" withPhoto:[UIImage imageNamed:@"Chartreux_small.png"] priced:[NSNumber numberWithInt:900] specialPriced:[NSNumber numberWithInt:0]];
    
    
    [PetDAO createFishNamed:@"Beta 1" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:22]];    
    [PetDAO createFishNamed:@"Beta 2" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:0]];    
    [PetDAO createFishNamed:@"Beta 3" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:24]];    
    [PetDAO createFishNamed:@"Beta 4" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:0]];    
    [PetDAO createFishNamed:@"Beta 5" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:20]];    
    [PetDAO createFishNamed:@"Beta 6" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:0]];    
    [PetDAO createFishNamed:@"Beta 7" born:[dateFormat dateFromString:@"2011-11-20"] ofRace:@"beta" colored:@"Blue" withPhoto:[UIImage imageNamed:@"betafish_small.png"] priced:[NSNumber numberWithInt:25] specialPriced:[NSNumber numberWithInt:0]];    

    [PetDAO createFishNamed:@"Clown 1" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]];    
    [PetDAO createFishNamed:@"Clown 2" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 3" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 4" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:200]]; 
    [PetDAO createFishNamed:@"Clown 5" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 6" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 7" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 8" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createFishNamed:@"Clown 9" born:[dateFormat dateFromString:@"2011-11-23"] ofRace:@"clown" colored:@"Red" withPhoto:[UIImage imageNamed:@"clownfish_small.png"] priced:[NSNumber numberWithInt:235] specialPriced:[NSNumber numberWithInt:0]]; 
   
    
    [PetDAO createReptileNamed:@"Belzebut" born:[dateFormat dateFromString:@"2011-09-11"] ofRace:@"Gecko" colored:@"White-Red" withPhoto:[UIImage imageNamed:@"TokayGecko_small.png"] priced:[NSNumber numberWithInt:732] specialPriced:[NSNumber numberWithInt:700]]; 
    [PetDAO createReptileNamed:@"Anna" born:[dateFormat dateFromString:@"2010-10-03"] ofRace:@"Acrochordidae" colored:@"Brown" withPhoto:[UIImage imageNamed:@"snake_small.png"] priced:[NSNumber numberWithInt:123] specialPriced:[NSNumber numberWithInt:0]]; 
    
    [PetDAO createBirdNamed:@"Piggy" born:[dateFormat dateFromString:@"2011-05-18"] ofRace:@"Crowned pigeon" colored:@"Blue" withPhoto:[UIImage imageNamed:@"crowned-pigeon_small.png"] priced:[NSNumber numberWithInt:2483] specialPriced:[NSNumber numberWithInt:0]]; 
    [PetDAO createBirdNamed:@"Bozo" born:[dateFormat dateFromString:@"2007-03-19"] ofRace:@"Cockatoo" colored:@"White" withPhoto:[UIImage imageNamed:@"cockatoo_small.png"] priced:[NSNumber numberWithInt:5510] specialPriced:[NSNumber numberWithInt:5250]]; 
    
    [[DataAccess instance] saveContext];
}

@end
