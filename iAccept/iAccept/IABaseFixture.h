//
//  Created by Pascal Roy on 12-01-05.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Framework-iAccept/IAFixture.h>

@interface IABaseFixture : NSObject<IAFixture>

@property (nonatomic, retain) id<UIApplicationDelegate> appDelegate;

@end
