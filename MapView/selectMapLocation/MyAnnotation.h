//
//  MyAnnotation.h
//  selectMapLocation
//
//  Created by Hemant Saini on 15/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property(strong,nonatomic)NSArray *timing;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *crossstreet;
@property (strong, nonatomic) NSString *mobileurl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *streetaddress;
@property (strong, nonatomic) NSString *supportedcardtypes;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *zip;

@end
