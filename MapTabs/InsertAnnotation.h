//
//  InsertAnnotation.h
//  MapTabs
//
//  Created by optimusmac4 on 7/22/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface InsertAnnotation : NSObject <MKAnnotation>


@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

//@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@end
