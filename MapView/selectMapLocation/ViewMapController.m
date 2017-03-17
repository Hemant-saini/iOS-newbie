//
//  ViewMapController.m
//  selectMapLocation
//
//  Created by Hemant Saini on 03/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import "ViewMapController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "ShowMapController.h"
#import "ShowDetailMapViewController.h"

@interface ViewMapController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL zoomLocation;
@property (nonatomic) NSInteger annotation;
@property (nonatomic, strong) MyAnnotation *selectedAnnotation;

@end


@implementation ViewMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    self.mapView.showsUserLocation = true;
    [self loadMockData];
}

- (void)loadMockData {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Locations"
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSError *error = nil;
    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get JSON data into a Foundation object
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
    for (NSDictionary *attraction in object) {
        [self.mapView addAnnotation:[[MyAnnotation alloc] initWithDict:attraction]];
    }
    [self panToLocationListMarkers:_mapView];
}

- (void)panToLocationListMarkers:(MKMapView *)mapView {
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id < MKAnnotation >)annotation {
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

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    self.selectedAnnotation = view.annotation;
    [self performSegueWithIdentifier:@"map" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"map"]) {
        ShowDetailMapViewController *samePage = (ShowDetailMapViewController *)[segue destinationViewController];
        samePage.sentAnnotation = self.selectedAnnotation;
    }
}

@end
