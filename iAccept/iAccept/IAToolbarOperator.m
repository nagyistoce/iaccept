//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAToolbarOperator.h"

@implementation IAToolbarOperator

+(IAToolbarOperator*) toolbarOperatorForUIToolbar:(UIToolbar*)uiToolbar {
    IAToolbarOperator* operator = [[IAToolbarOperator alloc] init];
    [operator setUiView:uiToolbar];
    return [operator autorelease];
}

-(UIToolbar*)uiToolbar {
    return (UIToolbar*)self.uiView;
}

-(void)touchButtonTitled:(NSString*)title {
    NSArray* items = self.uiToolbar.items;
    
    for(UIBarButtonItem* item in items) {
        if ([item.title isEqualToString:title]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [[item target] performSelector:item.action withObject:item];
#pragma clang diagnostic pop
            break;
        }
    }
}

@end
