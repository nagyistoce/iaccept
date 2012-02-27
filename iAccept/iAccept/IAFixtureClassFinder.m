//
//  Created by Pascal Roy on 11-12-23.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import "objc/runtime.h"
#import "IAFixtureClassFinder.h"
#import "IABaseFixture.h"
#import "SampleDefaultAppFixture.h"
#import "IADefaultAppFixture.h"

@implementation IAFixtureClassFinder

+(BOOL)isClassAnNSObject:(Class)aClass {
    Method m = class_getClassMethod(aClass , @selector(isSubclassOfClass:));

    return (m!=nil);
}



+(BOOL)isAFixture:(Class)aClass {
    if (![IAFixtureClassFinder isClassAnNSObject : aClass]) {
        return NO;
    }
    
    if ([aClass isSubclassOfClass:[IABaseFixture class]]) {
        return YES;
	}
	return NO;
}

+(BOOL)isNotABaseIAFixture:(Class)aClass {
    if (![NSStringFromClass(aClass) isEqualToString:NSStringFromClass([IABaseFixture class])]) {
        return YES;
	}
	return NO;
}

+(NSMutableArray*) discoverAllFixtures {
	NSMutableArray *array = [NSMutableArray array];
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        Class *classes = malloc(sizeof(Class) * numClasses);
        (void) objc_getClassList (classes, numClasses);
        int i;
        for (i = 0; i < numClasses; i++) {
            Class c = classes[i];
            if (![self isClassAnNSObject:c]) {
                continue;
            }
            
			if ([IAFixtureClassFinder isAFixture:c ] && [IAFixtureClassFinder isNotABaseIAFixture:c]) {
				[array addObject:c];
			}
        }
        free(classes);
    }
	return array;
}

+(NSArray*) findFixtureClasses {
    NSMutableArray* fixtures = [IAFixtureClassFinder discoverAllFixtures];
    
    return fixtures;
}

+(BOOL)isADefaultAppFixture:(Class)aClass {    
    if (![IAFixtureClassFinder isClassAnNSObject : aClass]) {
        return NO;
    }
    
    if ([aClass conformsToProtocol:@protocol(IADefaultAppFixture)]) {
        return YES;
	}
	return NO;
}

+(Class) discoverTheDefaultAppFixtures {
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        Class *classes = malloc(sizeof(Class) * numClasses);
        (void) objc_getClassList (classes, numClasses);
        int i;
        for (i = 0; i < numClasses; i++) {
            Class clazz = classes[i];
            
            if (![self isClassAnNSObject:clazz]) {
                continue;
            }
            
			if ([IAFixtureClassFinder isADefaultAppFixture:clazz] && 
                [IAFixtureClassFinder isNotABaseIAFixture:clazz]) {
				return clazz;
			}
        }
        free(classes);
    }
	return nil;
}

+(Class) findTheDefaultAppFixtureClass {
    Class defaultAppFixtureClass = [IAFixtureClassFinder discoverTheDefaultAppFixtures];    
    return defaultAppFixtureClass;
}


@end
