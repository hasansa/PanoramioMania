//
//  City.h
//  PanoramioMania
//
//  Created by Hasan_Sawaed on 8/9/13.
//  Copyright (c) 2013 Hasan_Sawaed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Country.h"

@class Country;

@interface City : NSObject

@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) Country *country;
    
@end

