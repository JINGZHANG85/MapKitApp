//
//  FirstViewController.m
//  StoreLocator
//
//  Created by Jing Zhang on 16/01/2013.
//  Copyright (c) 2013 com.jingzhang85. All rights reserved.
//

#import "FirstViewController.h"
#import "MapViewAnnotation.h"

@interface FirstViewController () {
    NSString *userLatitude;
    NSString *userlongitude;
    
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    userLatitude=@"";
    userlongitude=@"";
    
    self.mapView.delegate=self;
    self.mapView.showsUserLocation=YES;
    
    CLLocationCoordinate2D location;
	location.latitude = (double) 53.343986;
	location.longitude = (double) -6.249724;
    
    MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"Trinity College Sport Center" andCoordinate:location];
	[self.mapView addAnnotation:(id)newAnnotation];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    
    userLatitude=lat;
    userlongitude=lng;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.030;
    span.longitudeDelta=0.030;
    region.span=span;
    region.center=[userLocation coordinate];
    
    
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
