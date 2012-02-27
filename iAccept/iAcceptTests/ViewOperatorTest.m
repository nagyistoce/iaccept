//
//  Created by Nicolas Desjardins on 12-01-12.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ViewOperatorTest.h"

#import <UIKit/UIKit.h>
#import "IAViewOperator.h"
#import "IALabelOperator.h"
#import "IAButtonOperator.h"
#import "UIPickerViewDelegate.h"
#import "IAPickerOperator.h"
#import "IATextFieldOperator.h"


@implementation ViewOperatorTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testFindButtonIn1LevelSubviewWithText
{
    NSString* title = [NSString stringWithString:@"Button to find"];
                       
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIButton* buttonToFind = [[UIButton alloc]init];
    [buttonToFind setTitle:title forState:UIControlStateNormal];
    UIView* lev1_4 = [[UIView alloc]init];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:buttonToFind];
    [rootView addSubview:lev1_4];
    

    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
   
    IAButtonOperator* buttonFound = [operator searchForButtonWithText:title forState:UIControlStateNormal];
    
    STAssertNotNil(buttonFound, @"", nil);
    STAssertEqualObjects([buttonFound uiButton], buttonToFind, @"", nil);
}

- (void)testFindButtonIn2LevelSubviewWithText
{
    NSString* title = [NSString stringWithString:@"Button to find"];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIView* lev1_3 = [[UIView alloc]init];
    
    UIView* lev1_1_1 = [[UIView alloc]init];
    UIView* lev1_1_2 = [[UIView alloc]init];
    UIView* lev1_1_3 = [[UIView alloc]init];
    
    UIView* lev1_2_1 = [[UIView alloc]init];
    UIView* lev1_2_2 = [[UIView alloc]init];
    UIView* lev1_2_3 = [[UIView alloc]init];
    
    UIView* lev1_3_1 = [[UIView alloc]init];
    UIButton* buttonToFind = [[UIButton alloc]init];
    [buttonToFind setTitle:title forState:UIControlStateNormal];
    UIView* lev1_3_3 = [[UIView alloc]init];
    
    [lev1_1 addSubview:lev1_1_1];
    [lev1_1 addSubview:lev1_1_2];
    [lev1_1 addSubview:lev1_1_3];
    
    [lev1_2 addSubview:lev1_2_1];
    [lev1_2 addSubview:lev1_2_2];
    [lev1_2 addSubview:lev1_2_3];
    
    [lev1_3 addSubview:lev1_3_1];
    [lev1_3 addSubview:buttonToFind];
    [lev1_3 addSubview:lev1_3_3];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];

    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    
    IAButtonOperator* buttonFound = [operator searchForButtonWithText:title forState:UIControlStateNormal];
    
    STAssertNotNil(buttonFound, @"", nil);
    STAssertEqualObjects([buttonFound uiButton], buttonToFind, @"", nil);
}

- (void)testFindButtonIn1LevelSubviewWithImage
{
    UIImage *image = [UIImage imageWithContentsOfFile: [[NSBundle bundleForClass:[self class]] pathForResource:@"shopping_trolley" ofType:@"png"]];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIButton* buttonToFind = [[UIButton alloc]init];
    [buttonToFind setImage:image forState:UIControlStateNormal];
    UIView* lev1_4 = [[UIView alloc]init];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:buttonToFind];
    [rootView addSubview:lev1_4];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    
    IAButtonOperator* buttonFound = [operator searchForButtonWithImage:image forState:UIControlStateNormal];
    
    STAssertNotNil(buttonFound, @"", nil);
    STAssertEqualObjects([buttonFound uiButton], buttonToFind, @"", nil);
}

- (void)testFindButtonIn2LevelSubviewWithImage
{
    UIImage *image = [UIImage imageWithContentsOfFile: [[NSBundle bundleForClass:[self class]] pathForResource:@"shopping_trolley" ofType:@"png"]];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIView* lev1_3 = [[UIView alloc]init];
    
    UIView* lev1_1_1 = [[UIView alloc]init];
    UIView* lev1_1_2 = [[UIView alloc]init];
    UIView* lev1_1_3 = [[UIView alloc]init];
    
    UIView* lev1_2_1 = [[UIView alloc]init];
    UIView* lev1_2_2 = [[UIView alloc]init];
    UIView* lev1_2_3 = [[UIView alloc]init];
    
    UIView* lev1_3_1 = [[UIView alloc]init];
    UIButton* buttonToFind = [[UIButton alloc]init];
    [buttonToFind setImage:image forState:UIControlStateNormal];
    UIView* lev1_3_3 = [[UIView alloc]init];
    
    [lev1_1 addSubview:lev1_1_1];
    [lev1_1 addSubview:lev1_1_2];
    [lev1_1 addSubview:lev1_1_3];
    
    [lev1_2 addSubview:lev1_2_1];
    [lev1_2 addSubview:lev1_2_2];
    [lev1_2 addSubview:lev1_2_3];
    
    [lev1_3 addSubview:lev1_3_1];
    [lev1_3 addSubview:buttonToFind];
    [lev1_3 addSubview:lev1_3_3];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    
    IAButtonOperator* buttonFound = [operator searchForButtonWithImage:image forState:UIControlStateNormal];
    
    STAssertNotNil(buttonFound, @"", nil);
    STAssertEqualObjects([buttonFound uiButton], buttonToFind, @"", nil);
}

- (void)testFindUIViewOfClass
{
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UITableView* tableView = [[UITableView alloc] init];
    UIView* lev1_4 = [[UIView alloc]init];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:tableView];
    [rootView addSubview:lev1_4];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    
    IAViewOperator* tableViewOperator = [operator searchForViewOfClass:[UITableView class]];
    
    STAssertNotNil(tableViewOperator, @"", nil);
    STAssertEqualObjects([tableViewOperator uiView], tableView, @"", nil);
}

-(void)testFindUILabelOfWithText
{
//    NSString* text = @"Label text";
//    UIView* rootView = [[UIView alloc]init];
//    
//    UIView* lev1_1 = [[UIView alloc]init];
//    UIView* lev1_2 = [[UIView alloc]init];
//    UILabel* label = [[UILabel alloc] init];
//    [label setText:text];
//    UIView* lev1_4 = [[UIView alloc]init];
//    
//    [rootView addSubview:lev1_1];
//    [rootView addSubview:lev1_2];
//    [rootView addSubview:label];
//    [rootView addSubview:lev1_4];
//    
//    
//    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
//    IALabelOperator* labelViewOperator = [operator searchForLabelWithText:text];
//    
//    STAssertNotNil(labelViewOperator, @"", nil);
//    STAssertEqualObjects([labelViewOperator uiView], label, @"", nil);
}

- (void)testFindUITextFieldWithText
{
//    NSString* text = @"Label text";
//    UIView* rootView = [[UIView alloc]init];
//    
//    UIView* lev1_1 = [[UIView alloc]init];
//    UIView* lev1_2 = [[UIView alloc]init];
//    UITextField* textField = [[UITextField alloc] init];
//    [textField setText:text];
//    UIView* lev1_4 = [[UIView alloc]init];
//    
//    [rootView addSubview:lev1_1];
//    [rootView addSubview:lev1_2];
//    [rootView addSubview:textField];
//    [rootView addSubview:lev1_4];
//    
//    
//    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
//    IATextFieldOperator* textFieldViewOperator = [operator searchForTextFieldWithText:text];
//    
//    STAssertNotNil(textFieldViewOperator, @"", nil);
//    STAssertEqualObjects([textFieldViewOperator uiView], textField, @"", nil);
}

- (void)testPickerWithTitles {
    UIPickerViewDelegate* delegate = [[UIPickerViewDelegate alloc] init];

    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIPickerView* picker = [[UIPickerView alloc] init];
    [picker setDelegate:delegate];
    [picker setDataSource:delegate];
    
    UIView* lev1_4 = [[UIView alloc]init];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:picker];
    [rootView addSubview:lev1_4];
    
    NSArray* titles = [NSArray arrayWithObjects:@"Visa",@"MasterCard",@"Discover", nil];
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    IAPickerOperator* pickerOperator = [operator searchForPickerWithTitles:titles];
    
    STAssertNotNil(pickerOperator, @"", nil);
    STAssertEqualObjects([pickerOperator uiView], picker, @"", nil);
}

- (void)testSearchForViewsDelegatingTo {
    UIPickerViewDelegate* delegate1 = [[UIPickerViewDelegate alloc] init];
    UIPickerViewDelegate* delegate2 = [[UIPickerViewDelegate alloc] init];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIPickerView* lev1_1 = [[UIPickerView alloc]init];
    [lev1_1 setDelegate:delegate1];
    UIPickerView* lev1_2 = [[UIPickerView alloc]init];
    [lev1_2 setDelegate:delegate2];
    UIPickerView* lev1_3 = [[UIPickerView alloc]init];
    [lev1_3 setDelegate:delegate1];
    UIPickerView* lev1_4 = [[UIPickerView alloc]init];
    [lev1_4 setDelegate:delegate2];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    [rootView addSubview:lev1_4];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    NSArray* views = [operator searchForViewsDelegatingTo:delegate1];
    
    STAssertTrue([views count] == 2, @"", nil);
    IAViewOperator* lev1_1_operator = [views objectAtIndex:0];
    IAViewOperator* lev1_3_operator = [views objectAtIndex:1];
    
    STAssertEqualObjects([lev1_1_operator uiView], lev1_1, @"", nil);
    STAssertEqualObjects([lev1_3_operator uiView], lev1_3, @"", nil);
}

- (void)testSearchForViewsDelegatingToClass {
    UIPickerViewDelegate* delegate1 = [[UIPickerViewDelegate alloc] init];
    UIPickerViewDelegate* delegate2 = [[UIPickerViewDelegate alloc] init];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIPickerView* lev1_1 = [[UIPickerView alloc]init];
    [lev1_1 setDelegate:delegate1];
    UIPickerView* lev1_2 = [[UIPickerView alloc]init];
    [lev1_2 setDelegate:delegate2];
    UIPickerView* lev1_3 = [[UIPickerView alloc]init];
    [lev1_3 setDelegate:delegate1];
    UIPickerView* lev1_4 = [[UIPickerView alloc]init];
    [lev1_4 setDelegate:delegate2];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    [rootView addSubview:lev1_4];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    NSArray* views = [operator searchForViewsDelegatingToClass:[delegate1 class]];
    
    STAssertTrue([views count] == 4, @"", nil);
    IAViewOperator* lev1_1_operator = [views objectAtIndex:0];
    IAViewOperator* lev1_2_operator = [views objectAtIndex:1];
    IAViewOperator* lev1_3_operator = [views objectAtIndex:2];
    IAViewOperator* lev1_4_operator = [views objectAtIndex:3];
    
    STAssertEqualObjects([lev1_1_operator uiView], lev1_1, @"", nil);
    STAssertEqualObjects([lev1_2_operator uiView], lev1_2, @"", nil);
    STAssertEqualObjects([lev1_3_operator uiView], lev1_3, @"", nil);
    STAssertEqualObjects([lev1_4_operator uiView], lev1_4, @"", nil);
}

- (void)testSearchForViewWithPropertiesValues {
    UIPickerViewDelegate* delegate1 = [[UIPickerViewDelegate alloc] init];
    UIPickerViewDelegate* delegate2 = [[UIPickerViewDelegate alloc] init];
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    
    [properties setObject:delegate1 forKey:@"delegate"]; 
    [properties setObject:[NSNumber numberWithBool:YES] forKey:@"hidden"]; 
    [properties setObject:[NSNumber numberWithBool:YES] forKey:@"opaque"]; 
    
    UIView* rootView = [[UIView alloc]init];
    
    UIPickerView* lev1_1 = [[UIPickerView alloc]init];
    [lev1_1 setHidden:YES];
    [lev1_1 setOpaque:YES];
    [lev1_1 setDelegate:delegate1];
    UIPickerView* lev1_2 = [[UIPickerView alloc]init];
    [lev1_2 setDelegate:delegate2];
    UIPickerView* lev1_3 = [[UIPickerView alloc]init];
    [lev1_3 setDelegate:delegate1];
    [lev1_3 setOpaque:NO];
    UIPickerView* lev1_4 = [[UIPickerView alloc]init];
    [lev1_4 setDelegate:delegate2];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    [rootView addSubview:lev1_4];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    IAViewOperator* view = [operator searchForViewWithPropertiesValues:properties];
    
    STAssertNotNil(view, @"", nil);
    STAssertEqualObjects([view uiView], lev1_1, @"", nil);
}


- (void)testFindButtonInLevel1ButPresentIn2Levels
{
    UIButton* view1 = [[UIButton alloc]init];
    [view1 setTag:11];
    
    UIButton* view2 = [[UIButton alloc]init];
    [view2 setTag:22];
    
    UIButton* view3 = [[UIButton alloc]init];
    [view3 setTag:33];
    
    UIView* rootView = [[UIView alloc]init];
    
    UIView* lev1_1 = [[UIView alloc]init];
    UIView* lev1_2 = [[UIView alloc]init];
    UIView* lev1_3 = view1;
    
    UIView* lev1_1_1 = [[UIView alloc]init];
    UIView* lev1_1_2 = [[UIView alloc]init];
    UIView* lev1_1_3 = view2;
    
    UIView* lev1_1_2_1 = [[UIView alloc]init];
    UIView* lev1_1_2_2 = view3;
    UIView* lev1_1_2_3 = [[UIView alloc]init];

    
    [lev1_1 addSubview:lev1_1_1];
    [lev1_1 addSubview:lev1_1_2];
    [lev1_1 addSubview:lev1_1_3];
    
    [lev1_1_2 addSubview:lev1_1_2_1];
    [lev1_1_2 addSubview:lev1_1_2_2];
    [lev1_1_2 addSubview:lev1_1_2_3];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    
    
    IAViewOperator* operator = [IAViewOperator viewOperatorForUIView:rootView];
    
    IAViewOperator* viewFound = [operator searchForViewOfClass:[UIButton class] toDepth:0];
    
    STAssertNotNil(viewFound, @"", nil);
    STAssertEquals([viewFound tag], 11, @"", nil);
    
    viewFound = [operator searchForViewOfClass:[UIButton class] toDepth:1];
    
    STAssertNotNil(viewFound, @"", nil);
    STAssertEquals([viewFound tag], 22, @"", nil);
    
    viewFound = [operator searchForViewOfClass:[UIButton class] toDepth:2];
    
    STAssertNotNil(viewFound, @"", nil);
    STAssertEquals([viewFound tag], 33, @"", nil);
    
    NSMutableDictionary* properties = [[NSMutableDictionary alloc] init];
    [properties setObject:[UIButton class] forKey:@"class"];
    
    NSArray* views = [operator searchForViewsWithPropertiesValues:properties toDepth:0];
    
    STAssertNotNil(views, @"", nil);
    STAssertTrue([views count] == 1, @"", nil);
    
    views = [operator searchForViewsWithPropertiesValues:properties toDepth:1];
    
    STAssertNotNil(views, @"", nil);
    STAssertTrue([views count] == 2, @"", nil);
    
    views = [operator searchForViewsWithPropertiesValues:properties toDepth:2];
    
    STAssertNotNil(views, @"", nil);
    STAssertTrue([views count] == 3, @"", nil);
    
}

@end
