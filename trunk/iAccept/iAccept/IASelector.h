//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IAFixture;
@protocol IASelectorReturnValue;

@interface IASelector : NSObject

@property (nonatomic) SEL selector;
@property (nonatomic, retain) NSArray* argumentsAsStrings;

-(id) initWithSelector : (SEL) aSelector argumentsAsStrings : (NSArray*) theArgumentsAsStrings;
-(id<IASelectorReturnValue>) performOnFixture : (id<IAFixture>)aFixture;

@end
