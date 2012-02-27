#define IAAsyncWaitTrue( expressionToTest, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    BOOL (^expressionToTestBlock)(void) = ^ { return expressionToTest; }; \
    NSDate* runUntil; \
    while (! expressionToTestBlock() ) { \
        NSDate *endTime = [NSDate date];\
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
        if (timeInterval > timeoutInSeconds) { \
            break; \
        } \
    runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
    [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\



#define IAAsyncAssertTrue( expressionToTest, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    BOOL (^expressionToTestBlock)(void) = ^ { return expressionToTest; }; \
    NSDate* runUntil; \
    while (! expressionToTestBlock() ) { \
            NSDate *endTime = [NSDate date];\
            NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
            if (timeInterval > timeoutInSeconds) { \
                STFail(@"IAAsyncAssertTrue Timeout reached!"); \
                break; \
            } \
            runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
            [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\

#define IAAsyncWaitFalse( expressionToTest, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    BOOL (^expressionToTestBlock)(void) = ^ { return expressionToTest; }; \
    NSDate* runUntil; \
    while (expressionToTestBlock() ) { \
        NSDate *endTime = [NSDate date];\
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
        if (timeInterval > timeoutInSeconds) { \
            break; \
        } \
        runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
        [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\

#define IAAsyncAssertFalse( expressionToTest, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    BOOL (^expressionToTestBlock)(void) = ^ { return expressionToTest; }; \
    NSDate* runUntil; \
    while (expressionToTestBlock() ) { \
        NSDate *endTime = [NSDate date];\
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
        if (timeInterval > timeoutInSeconds) { \
            STFail(@"IAAsyncAssertFalse Timeout reached!"); \
            break; \
        } \
        runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
        [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\

#define IAAsyncWaitEqualObjects( expressionToTest, expectedValueExpression, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    NSObject* (^expressionToTestBlock)(void) = ^ { return (NSObject*)expressionToTest; }; \
    NSObject*  (^expectedValueExpressionBlock)(void) = ^ { return (NSObject*)expectedValueExpression; }; \
    NSDate* runUntil; \
    while (! [expressionToTestBlock() isEqual : expectedValueExpressionBlock()] ) { \
        NSDate *endTime = [NSDate date];\
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
        if (timeInterval > timeoutInSeconds) { \
            break; \
        } \
        runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
        [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\


#define IAAsyncAssertEqualObjects( expressionToTest, expectedValueExpression, aTimeoutInSeconds )   ({ \
    double timeoutInSeconds = aTimeoutInSeconds;\
    NSDate *startTime = [NSDate date];\
    NSObject* (^expressionToTestBlock)(void) = ^ { return (NSObject*)expressionToTest; }; \
    NSObject*  (^expectedValueExpressionBlock)(void) = ^ { return (NSObject*)expectedValueExpression; }; \
    NSDate* runUntil; \
    while (! [expressionToTestBlock() isEqual : expectedValueExpressionBlock()] ) { \
        NSDate *endTime = [NSDate date];\
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];\
        if (timeInterval > timeoutInSeconds) { \
            STFail(@"IAAsyncAssertEqualObjects Timeout reached!"); \
            break; \
        } \
        runUntil = [NSDate dateWithTimeIntervalSinceNow: 0.1 ]; \
        [[NSRunLoop currentRunLoop] runUntilDate:runUntil]; \
    } \
})\
