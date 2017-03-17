//
//  ViewMapController.m
//  selectMapLocation
//
//  Created by Hemant Saini on 03/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import "ViewMapController.h"
#import <CoreLocation/CoreLocation.h>
#import "showDetailForMap.h"
#import "MyAnnotation.h"

@interface ViewMapController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Locations"
                                                     ofType:@"json"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSError *error = nil;
    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get JSON data into a Foundation object
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    // Verify object retrieved is dictionary
    if ([object isKindOfClass:[NSDictionary class]] && !error) {
        NSLog(@"dictionary: %@", object);
    }
    NSLog(@"%@",content);
    self.mapView.showsUserLocation = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Locations"
                                                     ofType:@"json"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSError *error = nil;
    NSData *jsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get JSON data into a Foundation object
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    for (NSDictionary *attraction in object) {
        MyAnnotation *annotationObj = [[MyAnnotation alloc] init];
        annotationObj.coordinate = CLLocationCoordinate2DMake([attraction[@"latitude"] doubleValue], [attraction[@"longitude"] doubleValue]);
        annotationObj.name = attraction[@"name"];
        annotationObj.city = attraction[@"city"];
        annotationObj.country = attraction[@"country"];
        annotationObj.crossstreet = attraction[@"crossstreet"];
        annotationObj.mobileurl = attraction[@"mobileurl"];
        annotationObj.state = attraction[@"state"];
        annotationObj.title = attraction[@"storename"];
        annotationObj.streetaddress = attraction[@"streetaddress"];
        annotationObj.supportedcardtypes = attraction[@"supportedcardtypes"];
        annotationObj.telephone = attraction[@"telephone"];
        annotationObj.url = attraction[@"url"];
        annotationObj.zip = attraction [@"zip"];
        annotationObj.timing =attraction[@"timing"];
        
        [self.mapView addAnnotation:annotationObj];
    }
    [self panToLocationListMarkers];
    
}

- (void)panToLocationListMarkers {
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [_mapView setVisibleMapRect:zoomRect animated:YES];
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
    NSLog(@"annotation info====%@",self.selectedAnnotation);
    [self performSegueWithIdentifier:@"map" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"map"]) {
        showDetailForMap *samePage = (showDetailForMap *)[segue destinationViewController];
        samePage.sentAnnotation = self.selectedAnnotation;
    }
}

@end
