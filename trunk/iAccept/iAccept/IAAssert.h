//
//  Created by Pascal Roy on 11-11-13.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAIsEqualTo.h>
#import <Framework-iAccept/IAOperator.h>
@protocol IAOperator;

#define IA_VALUE(variable) [NSValue value:&variable withObjCType:@encode(__typeof__(variable))]
#define IA_INT(variable) [[NSNumber alloc] initWithInt: variable]

void IAAssertFail(NSString* errorMessage);
void IAAssertFalse(BOOL aValue, NSString* errorMessage);
void IAAssertTrue(BOOL aValue, NSString* errorMessage); 
void IAAssertThat(NSObject* anObject, id<IAOperator> anOperator);