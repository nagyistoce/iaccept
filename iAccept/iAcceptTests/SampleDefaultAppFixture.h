//
//  Created by Pascal Roy on 12-01-01.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IABaseFixture.h"
#import "IADefaultAppFixture.h"
@class IAThenResult;

@interface SampleDefaultAppFixture : IABaseFixture<IADefaultAppFixture>

-(void) iStartedTheApplication;
-(void) iDoSomething;
-(IAThenResult*) assertSomething;
-(void) someSettingIs : (NSString*)aString;

@end
