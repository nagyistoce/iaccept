//
//  Created by Nicolas Desjardins on 12-02-02.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IAControllerOperator : NSObject

+(IAControllerOperator*)createControllerOperatorForUIViewController:(UIViewController*)uiViewController;

@property(strong, nonatomic) UIViewController* uiViewController;

-(UIViewController*)searchForParentUIViewControllerOfClass:(Class)clazz;

@end
