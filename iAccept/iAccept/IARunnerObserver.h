//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IARunner;

@protocol IARunnerObserver <NSObject>
-(void) runnerDone : (IARunner*) aRunner;
@end
