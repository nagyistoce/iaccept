//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IANavigationBarOperator : IAViewOperator

+(IANavigationBarOperator*) navigationBarOperatorForUINavigationBar:(UINavigationBar*)navigationBar;

-(NSString*)title;

-(UINavigationBar*)uiNavigationBar;

-(void)touchLeftBarButton;
@end
