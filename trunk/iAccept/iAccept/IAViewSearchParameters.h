//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@protocol IAViewSearchParameters <NSObject>

@property(strong, nonatomic) IAViewOperator* viewOperator;
-(BOOL)keepThisView:(UIView*)view;

@end
