//
//  ViewMapController.h
//  selectMapLocation
//
//  Created by Hemant Saini on 03/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "ShowMapController.h"
#import "ShowDetailMapViewController.h"

@interface ViewMapController : UIViewController
@property (nonatomic) BOOL zoomLocation;
@property (nonatomic) NSInteger annotation;
@property (nonatomic, strong) MyAnnotation *selectedAnnotation;
@end
