//
//  Created by Nicolas Desjardins on 12-02-03.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIViewHierarchyWalkerTest.h"
#import "IAUIViewHierarchyWalker.h"

@implementation UIViewHierarchyWalkerTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testFindTopView
{
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
    
    UIView* lev1_2_1_1 = [[UIView alloc]init];
    UIView* lev1_2_1_2 = [[UIView alloc]init];
    UIView* lev1_2_1_3 = [[UIView alloc]init];
    
    UIView* lev1_3_1 = [[UIView alloc]init];
    UIView* lev1_3_2 = [[UIView alloc]init];    
    UIView* lev1_3_3 = [[UIView alloc]init];
    
    [lev1_1 addSubview:lev1_1_1];
    [lev1_1 addSubview:lev1_1_2];
    [lev1_1 addSubview:lev1_1_3];
    
    [lev1_2 addSubview:lev1_2_1];
    [lev1_2 addSubview:lev1_2_2];
    [lev1_2 addSubview:lev1_2_3];
    
    [lev1_2_1 addSubview:lev1_2_1_1];
    [lev1_2_1 addSubview:lev1_2_1_2];
    [lev1_2_1 addSubview:lev1_2_1_3];
    
    [lev1_3 addSubview:lev1_3_1];
    [lev1_3 addSubview:lev1_3_2];
    [lev1_3 addSubview:lev1_3_3];
    
    [rootView addSubview:lev1_1];
    [rootView addSubview:lev1_2];
    [rootView addSubview:lev1_3];
    
    UIView* topView = [IAUIViewHierarchyWalker findTopChildUIViewFromUIView:rootView];
    
    STAssertEqualObjects(topView, lev1_2_1_3, @"", nil);
    
}
@end
