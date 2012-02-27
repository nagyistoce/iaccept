//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IALabelOperator.h"

@implementation IALabelOperator

+(IALabelOperator*) labelOperatorForUILabel:(UILabel*)label {
    IALabelOperator* operator = [[IALabelOperator alloc] init];
    [operator setUiView:label];
    return [operator autorelease];
}

-(NSString*)text {
    return self.uiLabel.text;
}

-(void)setText:(NSString*)text {
    [[self uiLabel] setText:text];
}

-(UILabel*)uiLabel {
    return (UILabel*)[self uiView];
}

@end
