//
//  Created by Pascal Roy on 11-11-16.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAStatement.h>
@class IATest;

@interface IAExecuteAndWaitStatement : NSObject<IAStatement> {
    @private
    void (^executeBlock)();
    BOOL (^waitConditionBlock)();
    BOOL done;
}

@property (nonatomic, retain) IATest* parentTest;
@property (nonatomic) int suiteLineNo;
@property (nonatomic, copy) NSString* statementText;

- (id)initExecuteBlock : (void (^)())aTestBlock waitConditionBlock : (BOOL (^)())aWaitConditionBlock test : (IATest*) aParentTest suiteLineNo : (int)theSuiteLineNo;
- (void (^)()) getExecuteBlock;
- (BOOL (^)()) getWaitConditionBlock;

@end
