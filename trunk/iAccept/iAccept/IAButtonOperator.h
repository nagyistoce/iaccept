//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAButtonOperator : IAViewOperator

+(IAButtonOperator*) buttonOperatorForUIButton:(UIButton*)button;

-(UIButton*)uiButton;

-(BOOL)isEnabled;

-(void) touch;

@end
