//
//  Created by Nicolas Desjardins on 12-01-16.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Framework-iAccept/IAViewOperator.h>

@interface IASwitchOperator : IAViewOperator

+(IASwitchOperator*) switchOperatorForUISwitch:(UISwitch*)uiSwitch;

-(UISwitch*)uiSwitch;

-(void)touch;

@end
