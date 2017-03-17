//
//  MyAnnotation.m
//  selectMapLocation
//
//  Created by Hemant Saini on 15/03/17.
//  Copyright © 2017 Hemant Saini. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        self.coordinate = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
        self.name = self.title = dict[@"name"];
        self.city = dict[@"city"];
        self.country = dict[@"country"];
        self.crossstreet = dict[@"crossstreet"];
        self.mobileurl = dict[@"mobileurl"];
        self.state = dict[@"state"];
        self.streetaddress = dict[@"streetaddress"];
        self.supportedcardtypes = dict[@"supportedcardtypes"];
        self.telephone = dict[@"telephone"];
        self.url = dict[@"url"];
        self.zip = dict [@"zip"];
        self.timing =dict[@"timing"];
    }
    return self;
}

@end
