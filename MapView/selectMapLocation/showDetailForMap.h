//
//  showDetailForMap.h
//  selectMapLocation
//
//  Created by Hemant Saini on 07/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface showDetailForMap : UIViewController
    
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
@property (strong, nonatomic) MyAnnotation *sentAnnotation;

@end
