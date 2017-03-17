//
//  ViewMapController.h
//  selectMapLocation
//
//  Created by Hemant Saini on 03/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewMapController : UIViewController

@property(nonatomic) BOOL zoomLocation;
@property(nonatomic) int annotation;
@property (nonatomic,retain) MKPointAnnotation *selectedAnnotation;

@end
