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
#import "DetailViewController.h"


@interface SecondViewController ()

<CLLocationManagerDelegate>
{
    UIView *calloutView;
}

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
    
    [self calculateLoc];
    [self calculateLoc];
    
    // Adding the annotations
    
    MKCoordinateRegion bigBen = { {0.0, 0.0} , {0.0, 0.0} };
    bigBen.center.latitude = 23.383271;        // Coordinates of my home
    bigBen.center.longitude =85.3164882;
    bigBen.span.longitudeDelta = 0.02f;
    bigBen.span.latitudeDelta = 0.02f;
    [mapView setRegion:bigBen animated:YES];
    
    InsertAnnotation *ann1 = [[InsertAnnotation alloc] init];
    //ann1.title = @"My Home";
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

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *MyPin=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Current Location"];
    
    
    // These can be used if we use The MKPinAnnotationView
    //  MyPin.pinColor = MKPinAnnotationColorPurple;
    
    //  UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    // [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    // MyPin.rightCalloutAccessoryView = advertButton;
    //  MyPin.animatesDrop=TRUE;
    MyPin.image=[UIImage imageNamed:@"annot.png"];
    MyPin.draggable = NO;
    MyPin.highlighted = YES;
    
    MyPin.canShowCallout = NO;
    return MyPin;
}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    // Using the custom calloutview
    
    
    [self.mapView deselectAnnotation:view.annotation animated:YES];
   
    // Allows the selection of annotation again
    
    
    CGSize calloutSize = CGSizeMake(200.0, 80.0);
    
    calloutView = [[UIView alloc] initWithFrame:CGRectMake((view.frame.origin.x)/2-10, view.frame.origin.y-calloutSize.height, calloutSize.width, calloutSize.height)];
    
    calloutView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    UITextField *title=[[UITextField alloc] initWithFrame:CGRectMake(30, 10, 300, 20)];
    
    
    
    [title setTextColor:[UIColor whiteColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    calloutView.layer.cornerRadius = 5;
    
    calloutView.clipsToBounds = YES;
    
    button.frame = CGRectMake(80,50,40,20);
    
    [button setTitle:@"OK" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [title setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16 ]];
    
    [button setBackgroundColor:[UIColor blackColor]];
    
    [[button layer] setBorderWidth:1.0f];
    
    [[button layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    title.text=[NSString stringWithFormat:@"%@ %@",_address1,_address2];
    [title setEnabled:NO];
    
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Adding the title and button to the calloutView
    
    [calloutView addSubview:title];
    
    [calloutView addSubview:button];
    
    //Adding Callout the main view
    
    [view.superview addSubview:calloutView];
    
    
    
}

-(void)button:(id)sender
{
    // Performing seque to the DetailView

    [self performSegueWithIdentifier:@"detailView" sender:self];
    
}

//Current Location


-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    [[self labelLatitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.latitude]];
    [[self labelLongitude] setText:[NSString stringWithFormat:@"%.6f", location.coordinate.longitude]];
    [[self labelAltitude] setText:[NSString stringWithFormat:@"%.2f feet", location.altitude*METERS_FEET]];
    
    // zoom the map into the users current location
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
     //[[self mapView] setRegion:viewRegion animated:NO];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailView"])
    {
    DetailViewController *detView=segue.destinationViewController;
        
        detView.subLocalitytext=_address1;
        detView.localitytext=_address2;
        detView.adminAreatext=_address3;
        detView.countrytext=_address4;
        detView.pinCodetext=_address5;

    }
    
}


-(void)calculateLoc
{
    
    CLLocation *ourcoordinate=[[CLLocation alloc] initWithLatitude:23.383271 longitude:85.3164882];
    
    //Conversion into address using reverse Geocoding
    
    [geocoder reverseGeocodeLocation:ourcoordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0){
            
            placemark = [placemarks lastObject];
            
            _address1=placemark.subLocality;
            _address2=placemark.locality;
            _address3=placemark.administrativeArea;
            _address4=placemark.country;
            _address5=placemark.postalCode;
            
            _address = [NSString stringWithFormat:@"%@\t %@\t %@\t %@\t %@",
                        _address1,
                        _address2,
                        _address3,
                        _address4,
                        _address5];
        } else{
            
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
}
// Dismiss the callout on drag on MapView
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [calloutView removeFromSuperview];
}
@end
