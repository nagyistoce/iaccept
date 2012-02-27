//
//  Created by Nicolas Desjardins on 12-01-12.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "TableOperatorTest.h"
#import "IATableOperator.h"
#import "TableViewDelegate.h"

#import <UIKit/UIKit.h>

@implementation TableOperatorTest

- (void)testSelectRow
{ 
    TableViewDelegate* delegate = [[TableViewDelegate alloc] init];
    UITableView* tableView = [[UITableView alloc] init];
    [tableView setDelegate:delegate];
    [tableView setDataSource:delegate];
    IATableOperator* operator = [IATableOperator tableOperatorForUITableView:tableView];
    
    [operator selectRow:1 inSection:1];
    
    NSIndexPath* selectedRow = [tableView indexPathForSelectedRow];
    
    STAssertEquals([operator numberOfSections], 2, @"", nil);
    STAssertEquals([operator numberOfRowsInSection:1], 2, @"", nil);
    
    STAssertEquals([selectedRow row], 1, @"", nil);
    STAssertEquals([selectedRow section], 1, @"", nil);
    
    STAssertEquals([delegate numberOfSectionsInTableViewCallCount], 1, @"", nil);
    STAssertEquals([delegate numberOfRowsInSectionCallCount], 2, @"", nil);
    STAssertEquals(1, [delegate didSelectRowAtIndexPathCallCount], @"", nil);
    
}

@end