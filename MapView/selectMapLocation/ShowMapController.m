//
//ShowMapController.m
//  selectMapLocation
//
//  Created by Hemant Saini on 07/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//
#import "ShowMapController.h"
#import <MapKit/MapKit.h>

@interface ShowMapController()

@property (weak, nonatomic) IBOutlet UIView *viewMapDetails;
@property (weak, nonatomic) IBOutlet UILabel *showDistance;
@property (weak, nonatomic) IBOutlet MKMapView *detailMapView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *addressAndArea;
@property (weak, nonatomic) IBOutlet UILabel *distanceCalculate;
@property (weak, nonatomic) IBOutlet UILabel *weekDay;
@property (weak, nonatomic) IBOutlet UILabel *weekEndDay;
@property (weak, nonatomic) IBOutlet UILabel *openTiming;
@property (weak, nonatomic) IBOutlet UILabel *closeTime;

@end


@implementation ShowMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sentAnnotation = [[MyAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = [self getLocation];
    CLLocation *restaurantLocation = [[CLLocation alloc]  initWithLatitude:_sentAnnotation.coordinate.latitude longitude:_sentAnnotation.coordinate.longitude];
    CLLocation *myLoc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLLocationDistance distance = [restaurantLocation distanceFromLocation:myLoc];
    MKMapRect zoomRect = MKMapRectNull;
    MKMapPoint annotationPoint = MKMapPointForCoordinate(_sentAnnotation.coordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 1, 1);
    zoomRect = MKMapRectUnion(zoomRect, pointRect);
    [_detailMapView setVisibleMapRect:zoomRect animated:YES];
    [_detailMapView addAnnotation:_sentAnnotation];
    _restaurantName.text = _sentAnnotation.name;
    _distanceCalculate .text = [NSString stringWithFormat:@"%0.3f mi.", distance*0.000621371];
    _addressAndArea.text = [NSString stringWithFormat:@"%@  %@  %@  %@ %@",
                            _sentAnnotation.city,
                            _sentAnnotation.country,
                            _sentAnnotation.crossstreet,
                            _sentAnnotation.state,
                            _sentAnnotation.streetaddress];
    self.weekDay.text = [[[_sentAnnotation timing] objectAtIndex:0] valueForKey:@"day"];
    self.weekEndDay.text = [[[_sentAnnotation timing] objectAtIndex:1] valueForKey:@"day"];
    self.openTiming.text = [[[_sentAnnotation timing] objectAtIndex:0] valueForKey:@"time"];
    self.closeTime.text = [[[_sentAnnotation timing] objectAtIndex:1] valueForKey:@"time"];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *reuseId = @"StandardPin";
    MKAnnotationView *aView = (MKAnnotationView *)[sender dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (!aView) {
        aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.canShowCallout = YES;
    }
    aView.image = [UIImage imageNamed:@"mapAnnotation"];
    aView.annotation = annotation;
    aView.calloutOffset = CGPointMake(0, -5);
    aView.draggable = YES;
    aView.enabled = YES;
    return aView;
}

- (CLLocationCoordinate2D)getLocation {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
 

- (IBAction)btnDirectionTapped:(id)sender {
    NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",
                               [self getLocation].latitude,
                               [self getLocation].longitude,
                               _sentAnnotation.coordinate.latitude,
                               _sentAnnotation.coordinate.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL]];

}
    
- (IBAction)btnPhoneTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"tel://9876543210"]];
}

@end
