//
//  FirstViewController.m
//  MapTabs
//
//  Created by optimusmac4 on 7/22/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084
#import "FirstViewController.h"

@interface FirstViewController ()

<CLLocationManagerDelegate>

@end

@implementation FirstViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[self mapView] setShowsUserLocation:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [[self locationManager] setDelegate:self];
    
    // we have to setup the location maanager with permission in later iOS versions Hence checking here
    
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
}


// Updating and zooming on the location

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = locations.lastObject;
    [[self labelLatitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.latitude]];
    [[self labelLongitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.longitude]];
    [[self labelAltitude] setText:[NSString stringWithFormat:@"%.2f feet", location.altitude*METERS_FEET]];
    
    // zoom the map into the users current location and fixing the region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    [[self mapView] setRegion:viewRegion animated:YES];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//For segmented options for different modes
-(IBAction)setMap:(id)sender{
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
    {
        case 0:
            _mapView.mapType=MKMapTypeStandard;
            break;
            
        case 1:
            _mapView.mapType=MKMapTypeSatellite;
            break;
            
        case 2:
            _mapView.mapType=MKMapTypeHybrid;
            break;
            
            
        default:
            break;
    }
    
}

@end
