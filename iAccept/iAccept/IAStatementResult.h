//
//  Created by Pascal Roy on 11-11-11.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol IAStatement;

extern NSString * const IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_PASSED;
extern NSString * const IASTATEMENTRESULT_DESCRIPTION_TEMPLATE_FAILED;

@interface IAStatementResult : NSObject {
}

@property (nonatomic, retain) NSString* failureMessage;
@property (nonatomic, retain) id<IAStatement> statement;

-(id) initWithStatement : (id<IAStatement>) aStatement; 
-(id) initWithStatement : (id<IAStatement>) aStatement failureMessage : (NSString*) aFailureMessage;

+(id) newSuccess : (id<IAStatement>) aStatement;
+(id) newFailure : (id<IAStatement>) aStatement failureMessage : (NSString*) aFailureMessage;

-(BOOL) isFailure;
-(BOOL) isSuccess;

@end
