//
//  Created by Pascal Roy on 11-11-18.
//  Copyright 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IABaseBDDStatement.h>
@class IATest;

@interface IAWaitStatement : IABaseBDDStatement {
    @private
    BOOL (^waitConditionBlock)();
    BOOL isWaitConditionMet;
}
@property (nonatomic, retain) NSDate* waitStartTime;
@property (nonatomic, retain) IATest* parentTest;
@property (nonatomic) int suiteLineNo;

- (id)initWithWaitConditionBlock : (BOOL (^)())aWaitConditionBlock test : (IATest*) aTest suiteLineNo : (int)theSuiteLineNo;
- (BOOL (^)()) getWaitConditionBlock;

@end
