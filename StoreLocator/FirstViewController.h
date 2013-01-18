//
//  FirstViewController.h
//  StoreLocator
//
//  Created by Jing Zhang on 16/01/2013.
//  Copyright (c) 2013 com.jingzhang85. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FirstViewController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableData *XMLData;

@end
