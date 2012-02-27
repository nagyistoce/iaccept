//
//  Created by Pascal Roy on 12-01-14.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IASelector.h"
#import "IAFixture.h"
#import "IASelectorReturnValue.h"
#import "IASelectorVoidReturnValue.h"
#import "IASelectorObjectReturnValue.h"
#import "IASelectorDataTypeReturnValue.h"

@implementation IASelector

NSUInteger const INVOCATION_ARGUMENTS_START_INDEX = 2;
char const OBJECTIVE_C_VOID_RETURN_TYPE_ENCODING = 'v';
char const OBJECTIVE_C_VOID_OBJECT_TYPE_ENCODING = '@';

@synthesize selector;
@synthesize argumentsAsStrings;

-(id) initWithSelector : (SEL) aSelector argumentsAsStrings : (NSArray*) theArgumentsAsStrings {
    self = [super init];
    if (self) {
        self.selector = aSelector;
        self.argumentsAsStrings = theArgumentsAsStrings;
    }
    return self;
}

-(id<IASelectorReturnValue>) performOnFixture : (id<IAFixture>)aFixture {
    NSMethodSignature * methodSignature = [[aFixture class ] instanceMethodSignatureForSelector:selector];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    
    [invocation setSelector:selector];
    [invocation setTarget:aFixture];
    NSUInteger argumentCount = [argumentsAsStrings count];
    for (int argumentIndex = 0; argumentIndex < argumentCount; argumentIndex++) {
        NSString* argumentText = [argumentsAsStrings objectAtIndex : argumentIndex];
        [invocation setArgument: &argumentText atIndex:INVOCATION_ARGUMENTS_START_INDEX + argumentIndex];
    }
    [invocation invoke];
    
    const char* returnType = [[invocation methodSignature] methodReturnType];
    if (returnType[0] == OBJECTIVE_C_VOID_RETURN_TYPE_ENCODING) {
        return [[[IASelectorVoidReturnValue alloc] init] autorelease];
    }
    if (returnType[0] == OBJECTIVE_C_VOID_OBJECT_TYPE_ENCODING) {
        id anObject;
        [invocation getReturnValue:&anObject];
        return [[[IASelectorObjectReturnValue alloc] initWithValue:anObject] autorelease];
    }
    
    NSUInteger length = [[invocation methodSignature] methodReturnLength];
    void* buffer = (void *)malloc(length);
    [invocation getReturnValue:buffer];
    return [[[IASelectorDataTypeReturnValue alloc] initWithValue:buffer] autorelease];
}

@end
