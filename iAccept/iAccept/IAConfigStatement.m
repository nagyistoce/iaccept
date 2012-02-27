//
//  IAConfigStatement.m
//  iAccept
//
//  Created by Nicolas Desjardins on 12-02-27.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAConfigStatement.h"
#import "IAConfig.h"
#import "IAStatementResult.h"
#import "IATest.h"

@implementation IAConfigStatement

- (id)initWithStatementText : (NSString*)theStatementText test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo {
    self = [super initWithStatementText : theStatementText test:aTest suiteLineNo:theSuiteLineNo];
    if (self) {
    }
    return self;    
}

-(void) run {    
    NSArray *config = [self.statementText componentsSeparatedByString:@":"];
    if ([config count] == 2) {
        [[IAConfig sharedInstance] setValue:[config objectAtIndex:1] forKey:[config objectAtIndex:0]];
    }
    
    [self.parentTest performSelector:@selector(statementDoneRunning:) withObject:[IAStatementResult newSuccess : self]];
    
}

@end