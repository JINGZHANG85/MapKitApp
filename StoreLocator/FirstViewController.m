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
    
    [self performSelectorOnMainThread:@selector(getXMLData) withObject:self waitUntilDone:YES];
    
    
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

- (void)getXMLData {
    if (self.XMLData) {
        self.XMLData = nil;
    }
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maps.dublinbynumbers.com/phpsqlajax_genxml2.php?category_id=4&l1=0&l2=50"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        self.XMLData = [NSMutableData data];
    }
    
}

#pragma mark
#pragma Delegate Methods

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response {
    [self.XMLData setLength:0];
     
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data {
    
    if (self.XMLData) {
        [self.XMLData appendData:data];
    }
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection Error: %@ ", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    
   // [self startParsingData];
    [self performSelectorOnMainThread:@selector(startParsingData) withObject:self waitUntilDone:YES];

}


- (void)startParsingData {
    
    NSXMLParser *dataParser = [[NSXMLParser alloc] initWithData:self.XMLData];
    dataParser.delegate = self;
    
    [dataParser parse];
    
}

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"marker"]) {
        NSLog(@"Name: %@  /n Address: %@", [attributeDict objectForKey:@"name"], [attributeDict objectForKey:@"address"]);
        
        
        CLLocationCoordinate2D location;
        location.latitude = [[attributeDict objectForKey:@"lat"] doubleValue];
        location.longitude = [[attributeDict objectForKey:@"lng"] doubleValue];
        
        MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:[attributeDict objectForKey:@"name"] andCoordinate:location];
        [self.mapView addAnnotation:(id)newAnnotation];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSLog(@"Parsing Error");
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
