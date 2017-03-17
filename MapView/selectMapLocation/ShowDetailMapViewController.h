//
//  ShowDetailMapViewController.h
//  selectMapLocation
//
//  Created by Hemant Saini on 17/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"

@interface ShowDetailMapViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) MyAnnotation *sentAnnotation;

@end
