//
//  Created by Pascal Roy on 11-12-12.
//  Copyright (c) 2011 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IATest;

@protocol IATestObserver <NSObject>

-(void) testDone : (IATest*)aTest;

@end
