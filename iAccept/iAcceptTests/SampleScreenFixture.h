//
//  Created by Pascal Roy on 12-01-05.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IABaseFixture.h"
@class IAThenResult;

@interface SampleScreenFixture : IABaseFixture<NSObject>

@property (nonatomic) BOOL someValueIsMethodCalled;
@property (nonatomic, copy) NSString* someValueIsMethodParam;
@property (nonatomic, copy) NSString* iTouchButtonName;
@property (nonatomic, copy) NSString* iEnterTextText; 
@property (nonatomic, copy) NSString* andTouchButtonName;
@property int callCount;

-(void) iDidSomething;
-(void) iDidSomethingThatThrowsAnException;

-(void) iDoSomething;
-(void) iDoSomethingThatThrowsAnException;

-(IAThenResult*) assertSomething;
-(IAThenResult*) assertSomethingThatThrowsAnException;

-(void) pageTitleIs : (NSString*) aString;
-(IAThenResult*) someValueIs : (NSString*) aString;
-(IAThenResult*) checkForSomethingThatWillNeverHappen;

-(void)aThenStatementMethodThatDoesNotReturnAValue;

-(void) iEnterText : (NSString*)aText andTouchButton: (NSString*)aButtonName;

@end
