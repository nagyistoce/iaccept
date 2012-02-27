//
//  Created by Nicolas Desjardins on 12-01-19.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>


@interface IAOperatorFactory : NSObject

+(IAViewOperator*)createOperatorForUIView:(UIView*)uiView;

@end
