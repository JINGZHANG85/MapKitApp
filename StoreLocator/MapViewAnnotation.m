//
//  MapViewAnnotation.m
//  StoreLocator
//
//  Created by Jing Zhang on 16/01/2013.
//  Copyright (c) 2013 com.jingzhang85. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    return self;
}

@end
