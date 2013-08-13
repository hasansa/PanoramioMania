//
//  Location.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "City.h"

@import MapKit;

@class City;

@interface Location : NSObject

@property (nonatomic, strong) CLLocation * location;
@property (nonatomic, strong) City *city;
@property (nonatomic ,assign) double difficultyOffset ;


@end
