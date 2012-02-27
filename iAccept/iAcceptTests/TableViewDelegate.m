//
//  Created by Nicolas Desjardins on 12-01-13.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "TableViewDelegate.h"

@implementation TableViewDelegate

@synthesize numberOfSectionsInTableViewCallCount = _numberOfSectionsInTableViewCallCount;
@synthesize numberOfRowsInSectionCallCount = _numberOfRowsInSectionCallCount;
@synthesize didSelectRowAtIndexPathCallCount = _didSelectRowAtIndexPathCallCount;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    _numberOfSectionsInTableViewCallCount++;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _numberOfRowsInSectionCallCount++;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _didSelectRowAtIndexPathCallCount++;
    
}


@end
