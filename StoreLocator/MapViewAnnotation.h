//
//  MapViewAnnotation.h
//  StoreLocator
//
//  Created by Jing Zhang on 16/01/2013.
//  Copyright (c) 2013 com.jingzhang85. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
