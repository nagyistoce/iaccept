//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//


#import "IANavigationBarOperator.h"

@implementation IANavigationBarOperator

+(IANavigationBarOperator*) navigationBarOperatorForUINavigationBar:(UINavigationBar*)navigationBar {
    IANavigationBarOperator* operator = [[[IANavigationBarOperator alloc] init] autorelease];
    [operator setUiView:navigationBar];
    return operator;
}

-(NSString*)title {
    UINavigationItem* item  = [self.uiNavigationBar topItem];
    if (item.title.length != 0) {
        return item.title;
    } else {
        return @"";
    }
}

-(UINavigationBar*)uiNavigationBar {
    return (UINavigationBar*)[self uiView];
}

-(void)touchLeftBarButton {

    UINavigationItem* item = [self.uiNavigationBar topItem];
    UIBarButtonItem* backButton = item.leftBarButtonItem;

    if (backButton) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[backButton target] performSelector:[backButton action]];
#pragma clang diagnostic pop
    } else {
        [[self.uiNavigationBar delegate] popViewControllerAnimated:NO];
    }
}

@end
