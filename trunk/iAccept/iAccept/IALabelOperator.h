//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IALabelOperator : IAViewOperator

+(IALabelOperator*) labelOperatorForUILabel:(UILabel*)label;

-(NSString*)text;

-(void)setText:(NSString*)text;

-(UILabel*)uiLabel;

@end
