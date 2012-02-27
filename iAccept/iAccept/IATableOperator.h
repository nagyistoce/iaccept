//
//  Created by Nicolas Desjardins on 12-01-11.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IATableOperator : IAViewOperator


+(IATableOperator*) tableOperatorForUITableView:(UITableView*)tableView;

-(UITableView*)uiTableView;

-(IAViewOperator*)cellForRow:(int)row inSection:(int)section;
-(void)selectRow:(int)row inSection:(int)section;
-(int)numberOfSections;
-(int)numberOfRowsInSection:(int)section;
-(void)selectCell:(IAViewOperator*)cellViewOperator;
-(void)unselect;

-(IAViewOperator*)searchForCellContainingALabelWithText:(NSString*)text;
      
-(IAViewOperator*)searchForCellContainingAViewWithProperties:(NSDictionary*)properties;



@end
