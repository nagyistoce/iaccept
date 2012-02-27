//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Framework-iAccept/IAViewOperator.h>

@interface IAMapOperator : IAViewOperator

+(IAMapOperator*) mapOperatorForMKMapView:(MKMapView*)mkMapView;

-(NSArray*)annotations;

-(MKCoordinateRegion)coordinateRegion;

-(MKMapView*)mkMapView;

@end
