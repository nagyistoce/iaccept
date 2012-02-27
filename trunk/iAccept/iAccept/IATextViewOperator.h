//
//  Created by Nicolas Desjardins on 12-02-04.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAScrollViewOperator.h>

@interface IATextViewOperator : IAViewOperator

+(IATextViewOperator*) textViewOperatorForUITextView:(UITextView*)textView;

-(UITextView*)uiTextView;

-(NSString*)text;

-(void)setText:(NSString*)text;

-(BOOL)containsText:(NSString*)text;

-(IAScrollViewOperator*)scrollViewOperator;

@end
