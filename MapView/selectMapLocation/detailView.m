//
//  detailView.m
//  selectMapLocation
//
//  Created by Hemant Saini on 15/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import "detailView.h"

@implementation detailView
newAnnotation = [[MyAnnotation alloc] init];
newAnnotation.title = dictionary[@"applicant"];
newAnnotation.subtitle = dictionary[@"company"];
newAnnotation.status = dictionary[@"status"];
newAnnotation.company = dictionary[@"company"];
newAnnotation.coordinate = location;
[newAnnotations addObject:newAnnotation];
@end
