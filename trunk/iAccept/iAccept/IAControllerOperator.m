//
//  Created by Nicolas Desjardins on 12-02-02.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAControllerOperator.h"

@implementation IAControllerOperator

@synthesize uiViewController = _uiViewController;


+(IAControllerOperator*)createControllerOperatorForUIViewController:(UIViewController*)uiViewController {
    IAControllerOperator* operator = [[IAControllerOperator alloc] init];
    [operator setUiViewController:uiViewController];
    return [operator autorelease];
}

-(UIViewController*)searchForParentUIViewControllerOfClass:(Class)clazz {
    
    UIViewController* currentViewController = _uiViewController;
    
    while ([currentViewController parentViewController] != nil) {
        currentViewController = [currentViewController parentViewController];
        if ([currentViewController isKindOfClass:clazz]) {
            return currentViewController;
        }
    }
    return nil;
}

@end
