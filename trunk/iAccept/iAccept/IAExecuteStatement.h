//
//  Created by Pascal Roy on 11-11-16.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatement.h>
@protocol IATestSuite;
@class IATest;

@interface IAExecuteStatement : NSObject<IAStatement> {
    @private
    void (^executeBlock)();
}

@property (nonatomic, retain) IATest* parentTest;
@property (nonatomic) int suiteLineNo;

- (id)initValidateBlock : (void (^)())aValidateBlock test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo;
- (void (^)()) getExecuteBlock;

@end
