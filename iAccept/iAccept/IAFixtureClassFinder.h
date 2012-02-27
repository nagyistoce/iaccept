//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAFixtureClassFinder : NSObject

+(NSArray*) findFixtureClasses;
+(Class) findTheDefaultAppFixtureClass;

@end
