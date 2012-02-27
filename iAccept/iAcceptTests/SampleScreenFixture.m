//
//  Created by Pascal Roy on 12-01-05.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "SampleScreenFixture.h"
#import "IAThenResult.h"
#import "IAException.h"

@implementation SampleScreenFixture

@synthesize someValueIsMethodCalled;
@synthesize someValueIsMethodParam;
@synthesize iTouchButtonName;
@synthesize iEnterTextText;
@synthesize andTouchButtonName;
@synthesize callCount;

-(id) init {
    self = [super init];
    if (self) {
        self.someValueIsMethodCalled = NO;
        callCount = 0;
    }
    return self;
}

-(void) dealloc {
    [iTouchButtonName release];
    [someValueIsMethodParam release];
    [iEnterTextText release];
    [andTouchButtonName release];
    [super dealloc];
}

-(void) iDidSomething {
}

-(void) iDidSomethingThatThrowsAnException {
    [IAException raise:(@"Something was wrong on action")];
}

-(void) iDoSomething {
}

-(void) iDoSomethingThatThrowsAnException {
    [IAException raise:(@"Something was wrong on action")];
}


-(IAThenResult*) assertSomething {
    return [IAThenResult makeThenStatementConditionMetReturnValue];
}

-(IAThenResult*) assertSomethingThatThrowsAnException {
    [IAException raise:@"Something was wrong on assert"];
    return nil;
}

-(void) pageTitleIs : (NSString*) aString {    
}

-(IAThenResult*) someValueIs : (NSString*) aString {
    someValueIsMethodCalled = YES;
    self.someValueIsMethodParam = aString;
    return [IAThenResult makeThenStatementConditionMetReturnValue];
}

-(IAThenResult*) checkForSomethingThatWillNeverHappen {    
    return [IAThenResult makeThenStatementConditionNotMetValue:@"Value should be 4, was 5"];
}

-(IAThenResult*) checkForRecallAfterDelayExpires {    
    if (callCount >= 20) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"recall done, you can fail" andForceRecall:NO];
    } else {
        callCount++;
        return [IAThenResult makeThenStatementConditionNotMetValue:@"recall me again please!" andForceRecall:YES]; 
    }
}

-(void) iEnterText : (NSString*)aText andTouchButton: (NSString*)aButtonName {
    self.iEnterTextText = aText;
    self.andTouchButtonName = aButtonName;
}

-(void) iTouchAButtonNamed : (NSString*) aButtonName {
    self.iTouchButtonName = aButtonName;
}

-(void)aThenStatementMethodThatDoesNotReturnAValue {
}

@end
