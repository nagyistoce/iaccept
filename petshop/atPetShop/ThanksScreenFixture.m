//
//  ThanksScreenFixture.m
//  PetShop
//
//  Created by Nicolas Desjardins on 12-02-01.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "ThanksScreenFixture.h"
#import <MapKit/MapKit.h>
#import <Framework-iAccept/IAThenResult.h>
#import <Framework-iAccept/IASplitViewOperator.h>
#import <Framework-iAccept/IAViewOperator.h>
#import <Framework-iAccept/IAMapOperator.h>


@implementation ThanksScreenFixture

-(IAThenResult*)mapShowsTheShopLocation {
    IASplitViewOperator* splitOperator = [IASplitViewOperator splitViewOperatorForAppDelegate:[self appDelegate]]; 
    IAViewOperator* detailOperator = [splitOperator rootViewOfDetailViewOperator];
    IAMapOperator* mapOperator = (IAMapOperator*)[detailOperator searchForViewOfClass:[MKMapView class]];
    
    NSArray* annotations = [mapOperator annotations];
    
    if (!mapOperator) {
        return [IAThenResult makeThenStatementConditionNotMetValue:@"Expected one map, none found."];
    } else if ([annotations count] != 1) {
        return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected only one pin on map, %@ found.",[annotations count]]];
    } else {
        id<MKAnnotation> annotation = [annotations objectAtIndex:0];
        CLLocationCoordinate2D coordinates = [annotation coordinate];

        if (coordinates.latitude != 45.508867 && coordinates.longitude != -73.554242){
            return [IAThenResult makeThenStatementConditionNotMetValue:[NSString stringWithFormat:@"Expected coordinates (%@,%@), found (%@,%@).","45.508867","-73.554242", coordinates.latitude, coordinates.longitude]];
        }
        return [IAThenResult makeThenStatementConditionMetReturnValue];
    }
}

@end
