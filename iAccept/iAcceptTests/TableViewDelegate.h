//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) int didSelectRowAtIndexPathCallCount;
@property(nonatomic) int numberOfSectionsInTableViewCallCount;
@property(nonatomic) int numberOfRowsInSectionCallCount;
@end
