//
//  Created by Pascal Roy on 11-11-08.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAOperator.h>

@interface IAIsEqualTo : NSObject<IAOperator> {
}
@property (nonatomic, retain) NSObject* targetObject;
@property (nonatomic, copy) NSObject* errorMessage;

-(id) initWithObject : (NSObject*) aTargetObject;
-(id) initWithObject : (NSObject*) aTargetObject errorMessage : (NSString*)anErrorMessage;

id isEqualTo(NSObject* object);
id isEqualToWithMessage(NSObject* aTargetObject, NSString* aMessage);

-(void) operateOn : (NSObject*) sourceObject;

@end
