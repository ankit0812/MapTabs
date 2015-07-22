//
//  SecondViewController.m
//  MapTabs
//
//  Created by optimusmac4 on 7/22/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#define METERS_MILE 1609.344                // For conversion purpose
#define METERS_FEET 3.28084


#import "SecondViewController.h"
#import "InsertAnnotation.h"
@interface SecondViewController ()

<CLLocationManagerDelegate>

@end

@implementation SecondViewController

@synthesize mapView;

CLLocationManager *manager;
CLGeocoder *geocoder;
CLPlacemark *placemark;


-(void)viewDidLoad

{
    
    [super viewDidLoad];
    
    [mapView setDelegate:self];
    
    [[self mapView] setShowsUserLocation:YES];
    
    manager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [[self locationManager] setDelegate:self];
    
    // we have to setup the location maanager with permission in later iOS versions
    
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)])
    
    {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    [[self locationManager] startUpdatingLocation];
    
    // Adding the annotations
    
    MKCoordinateRegion bigBen = { {0.0, 0.0} , {0.0, 0.0} };
    bigBen.center.latitude = 23.3773262;        // Coordinates of my home
    bigBen.center.longitude =85.319214;
    bigBen.span.longitudeDelta = 0.02f;
    bigBen.span.latitudeDelta = 0.02f;
    [mapView setRegion:bigBen animated:YES];
    
    InsertAnnotation *ann1 = [[InsertAnnotation alloc] init];
    ann1.title = @"My Home";
    ann1.subtitle = @"Ranchi";
    ann1.coordinate = bigBen.center;
    [mapView addAnnotation: ann1];
    
    /* If we want to add one more annotation we can uncomment this section
     
     
     MKCoordinateRegion new = { {0.0, 0.0} , {0.0, 0.0} };
     new.center.latitude = 51.50063;
     new.center.longitude = -0.114629;
     new.span.longitudeDelta = 0.02f;
     new.span.latitudeDelta = 0.02f;
     [mapView setRegion:new animated:YES];
     
     InsertAnnotation *ann2 = [[InsertAnnotation alloc] init];
     ann2.title = @"Florenece Museum";
     ann2.subtitle = @"London";
     ann2.coordinate = new.center;
     [mapView addAnnotation:ann2]; */
    
    
}

// Properties of viewing the annotation i.e. for here the pin

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation

{
    MKPinAnnotationView *MyPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    MyPin.pinColor = MKPinAnnotationColorPurple;
    
    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    MyPin.rightCalloutAccessoryView = advertButton;
    MyPin.draggable = NO;
    MyPin.highlighted = YES;
    MyPin.animatesDrop=TRUE;
    MyPin.canShowCallout = YES;
    
    return MyPin;
}

// Displaying the address

-(void)button:(id)sender
{
    
    CLLocation *ourcoordinate=[[CLLocation alloc] initWithLatitude:23.3773262 longitude:85.319214];
    
    //Conversion into address using reverse Geocoding
    
    [geocoder reverseGeocodeLocation:ourcoordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        
    if (error == nil && [placemarks count] > 0)
    {
            
            placemark = [placemarks lastObject];
            
            _address = [NSString stringWithFormat:@"%@\n%@ %@\n%@\n%@",
                        placemark.thoroughfare,
                        placemark.postalCode, placemark.locality,
                        placemark.administrativeArea,
                        placemark.country];
        
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Address"
                                                              message:_address
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
        
            [message show];
            
    }
    else
        {
            
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
    
    
}

//Current Location


-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    [[self labelLatitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.latitude]];
    [[self labelLongitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.longitude]];
    [[self labelAltitude] setText:[NSString stringWithFormat:@"%.2f feet", location.altitude*METERS_FEET]];
    
    // zoom the map into the users current location
    /*MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
     [[self mapView] setRegion:viewRegion animated:NO];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//Segemented display for various map types

-(IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
    {
        case 0:
            mapView.mapType=MKMapTypeStandard;
            break;
            
        case 1:
            mapView.mapType=MKMapTypeSatellite;
            break;
            
        case 2:
            mapView.mapType=MKMapTypeHybrid;
            break;
            
            
        default:
            break;
    }
}

@end
