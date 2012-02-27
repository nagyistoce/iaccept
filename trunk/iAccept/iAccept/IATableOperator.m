//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IATableOperator.h"

@interface IATableOperator()

@end

@implementation IATableOperator

+(IATableOperator*) tableOperatorForUITableView:(UITableView*)tableView {
    IATableOperator* operator = [[[IATableOperator alloc] init] autorelease];
    [operator setUiView:tableView];
    return operator;
}

-(void)selectRow:(int)row inSection:(int)section {
    NSIndexPath* path = [NSIndexPath indexPathForRow:row inSection:section];
    [[self uiTableView] selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
    [[[self uiTableView] delegate] tableView:[self uiTableView] didSelectRowAtIndexPath:path];
}

-(void)unselect {
    [self.uiTableView deselectRowAtIndexPath:[self.uiTableView indexPathForSelectedRow] animated:NO];
}

-(UITableView*)uiTableView {
    return (UITableView*)[super uiView];
}

-(int)numberOfSections {
    return [self.uiTableView numberOfSections];
}
-(int)numberOfRowsInSection:(int)section {
    return [self.uiTableView numberOfRowsInSection:section];
}

-(IAViewOperator*)cellForRow:(int)row inSection:(int)section {
    NSIndexPath* path = [NSIndexPath indexPathForRow:row inSection:section];
    return [IAViewOperator viewOperatorForUIView:[self.uiTableView cellForRowAtIndexPath:path]];
}

-(void)selectCell:(IAViewOperator*)cellViewOperator {
    NSIndexPath* cellPath = [self.uiTableView indexPathForCell:(UITableViewCell*)[cellViewOperator uiView]];
    [self selectRow:[cellPath row] inSection:[cellPath section]];
}

-(IAViewOperator*)searchForCellContainingALabelWithText:(NSString*)text {
    int sectionCount = self.numberOfSections;
    for (int i=0;i<sectionCount;i++) {
        int rowCount = [self numberOfRowsInSection:i];
        for (int j=0;j<rowCount;j++) {
            IAViewOperator* cellOperator = [self cellForRow:j inSection:i];
            if ([cellOperator searchForLabelWithText:text]) {
                return cellOperator;
            }
        }
    }
    return nil;
}

-(IAViewOperator*)searchForCellContainingAViewWithProperties:(NSDictionary*)properties {
    int sectionCount = self.numberOfSections;
    for (int i=0;i<sectionCount;i++) {
        int rowCount = [self numberOfRowsInSection:i];
        for (int j=0;j<rowCount;j++) {
            IAViewOperator* cellOperator = [self cellForRow:j inSection:i];
            if ([cellOperator searchForViewWithPropertiesValues:properties]) {
                return cellOperator;
            }
        }
    }
    return nil;
}

@end
