//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATextViewOperator.h"

@implementation IATextViewOperator

+(IATextViewOperator*) textViewOperatorForUITextView:(UITextView*)textView {
    IATextViewOperator* operator = [[IATextViewOperator alloc] init];
    [operator setUiView:textView];
    return [operator autorelease];
}

-(UITextView*)uiTextView {
    return (UITextView*)[self uiView];
}

-(NSString*)text {
    return [[self uiTextView] text];
}

-(void)setText:(NSString*)text {
    [[self uiTextView] setText:text];
}

-(BOOL)containsText:(NSString*)text {
    return [[self text] rangeOfString:text].location != NSNotFound;
}

-(IAScrollViewOperator*)scrollViewOperator {
    return [IAScrollViewOperator scrollViewOperatorForUIScrollView:(UIScrollView*)self.uiView];
}

@end
