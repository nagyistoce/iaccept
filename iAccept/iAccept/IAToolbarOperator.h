//
//  Created by Nicolas Desjardins on 12-02-09.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAToolbarOperator : IAViewOperator

+(IAToolbarOperator*) toolbarOperatorForUIToolbar:(UIToolbar*)uiToolbar;

-(UIToolbar*)uiToolbar;

-(void)touchButtonTitled:(NSString*)title; 
@end
