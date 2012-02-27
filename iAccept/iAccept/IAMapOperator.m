//
//  Created by Nicolas Desjardins on 12-01-31.
//  Copyright (c) 2012 Elapse Technologies. All rights reserved.
//

#import "IAMapOperator.h"

@implementation IAMapOperator

+(IAMapOperator*) mapOperatorForMKMapView:(MKMapView*)mkMapView {
    IAMapOperator* operator = [[IAMapOperator alloc] init];
    [operator setUiView:mkMapView];
    return [operator autorelease]; 
}

-(NSArray*)annotations {
    return [self.mkMapView annotations];
}

-(MKCoordinateRegion)coordinateRegion {
    return [self.mkMapView region];
}

-(MKMapView*)mkMapView {
    return (MKMapView*)self.uiView;
}

@end
