//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAAlertViewOperator : IAViewOperator

+(IAAlertViewOperator*) alertViewOperator;

+(IAAlertViewOperator*) alertViewOperatorForUIAlertView:(UIAlertView*)uiAlertView;

-(UIAlertView*)uiAlertView;

-(NSString*)title;

-(NSString*)message;

-(void)touchCancelButton;

@end
